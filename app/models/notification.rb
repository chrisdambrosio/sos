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
    case contact_method.contact_type
    when :sms
      @client.account.sms.messages.create(
        from: '8583975407',
        to: contact_method.address,
        body: alert.description
      )
    when :phone
      url = "http://pagernova.herokuapp.com/twilio/phone?alert_id=#{alert.id}"
      puts 'url is ' + url
      @client.account.calls.create(
        from: '8583975407',
        to: contact_method.address,
        url: "http://pagernova.herokuapp.com/twilio/phone?alert_id=#{alert.id}",
        method: 'GET'
      )
    end
  end

  private

  def before_create_hook
    self.status = 'queued'
  end
end
