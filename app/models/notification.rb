class Notification < ActiveRecord::Base
  belongs_to :alert
  belongs_to :user
  has_many :log_entries
  validates :alert, presence: true
  validates :user, presence: true
  scope :ready_to_send, -> { where(status: 'queued').where('send_at <= ?', Time.now) }
  before_create :before_create_hook

  def contact_method=(contact_method)
    self.address = contact_method.address
    self.contact_type = contact_method.contact_type
    self.user = contact_method.user
  end

  def deliver
    account_sid = 'ACcd51106c4d0acaa0fc724076364ac9be'
    auth_token = '96a7560ca19c80bc79ae4afe9238828d'

    @client = Twilio::REST::Client.new(account_sid, auth_token)
    case contact_type
    when :sms
      token = SmsReplyToken.create(
        user: user,
      )
      @client.account.sms.messages.create(
        from: '8583975407',
        to: address,
        body: "SOS##{alert.id}: #{alert.description}. " +
              "Reply #{token.acknowledge_code}:Ack, " +
              "#{token.resolve_code}:Resolv"
      )
      json = @client.last_response.body
      source_address = JSON.parse(json)['to']
      token.update_attributes(alert: alert, source_address: source_address)
    when :phone
      url = "http://pagernova.herokuapp.com/twilio/phone?notification_id=#{id}"
      @client.account.calls.create(
        from: '8583975407',
        to: address,
        url: url
      )
    when :email
      api_key = 'f37ce78c-7afc-4aa8-99a0-70b8f7635f65'
      client = Postmark::ApiClient.new(api_key, secure: true)
      client.deliver(
        from: 'chris_dambrosio@playstation.sony.com',
        to: "#{user.name} <#{address}>",
        subject: "Alert: #{alert.description}",
        text_body: alert.description
      )
    end
    log_notification
  end

  def log_notification
    LogEntry.create(alert: alert, action: 'notify', notification: self, user: user)
  end

  def contact_type
    super.to_sym unless super.nil?
  end

  private

  def before_create_hook
    self.status = 'queued'
  end
end
