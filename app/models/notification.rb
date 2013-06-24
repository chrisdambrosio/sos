class Notification < ActiveRecord::Base
  belongs_to :contact_method
  belongs_to :alert
  validates :contact_method, presence: true
  validates :alert, presence: true
  scope :ready_to_send, -> { where(status: 'queued').where('send_at <= ?', Time.now) }
  before_create :before_create_hook

  def deliver
    account_sid = 'ACcd51106c4d0acaa0fc724076364ac9be'
    auth_token = '96a7560ca19c80bc79ae4afe9238828d'

    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @client.account.sms.messages.create(
      from: '8583975407',
      to: contact_method.address,
      body: alert.description
    )
  end

  private

  def before_create_hook
    self.status = 'queued'
  end
end
