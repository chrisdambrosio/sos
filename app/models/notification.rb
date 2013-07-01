class Notification < ActiveRecord::Base
  belongs_to :contact_method
  belongs_to :alert
  has_many :log_entries, as: :objectable
  validates :contact_method, presence: true
  validates :alert, presence: true
  scope :ready_to_send, -> { where(status: 'queued').where('send_at <= ?', Time.now) }
  before_create :before_create_hook

  def deliver
    account_sid = 'ACcd51106c4d0acaa0fc724076364ac9be'
    auth_token = '96a7560ca19c80bc79ae4afe9238828d'

    @client = Twilio::REST::Client.new(account_sid, auth_token)
    case contact_method.contact_type
    when :sms
      @client.account.sms.messages.create(
        from: '8583975407',
        to: contact_method.address,
        body: alert.description
      )
    when :phone
      url = "http://pagernova.herokuapp.com/twilio/phone?alert_id=#{alert.id}"
      @client.account.calls.create(
        from: '8583975407',
        to: contact_method.address,
        url: url,
        method: 'GET'
      )
    when :email
      api_key = 'f37ce78c-7afc-4aa8-99a0-70b8f7635f65'
      client = Postmark::ApiClient.new(api_key, secure: true)
      client.deliver(
        from: 'chris_dambrosio@playstation.sony.com',
        to: "#{contact_method.user.name} <#{contact_method.address}>",
        subject: "Alert: #{alert.description}",
        text_body: alert.description
      )
    end
  end

  private

  def before_create_hook
    self.status = 'queued'
  end
end
