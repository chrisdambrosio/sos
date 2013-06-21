class TwilioController < ActionController::Base
  def sms
    logger.info params
    twiml = Twilio::TwiML::Response.new do |r|
      r.Sms 'responding back'
    end
    render text: twiml.text
  end
end
