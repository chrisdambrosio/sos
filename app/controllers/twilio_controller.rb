class TwilioController < ActionController::Base
  def sms
    logger.info params
    twiml = Twilio::TwiML::Response.new do |r|
      r.Sms 'responding back'
    end
    render text: twiml.text
  end

  def phone
    logger.info params
    alert = Alert.find(params[:alert_id])
    twiml = Twilio::TwiML::Response.new do |r|
      r.Say 'Hello, you have received the following alert:'
      r.Say alert.description
      r.Say ', Good bye!'
    end
    render text: twiml.text
  end
end
