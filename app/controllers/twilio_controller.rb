class TwilioController < ActionController::Base
  def sms
    tokens = SmsReplyToken.where(source_address: params['From'])
    @token = tokens.with_reply_code(params['Body'])

    if @token
      @alert = @token.alert
      @alert.agent = @token.user
      @alert.channel = { type: 'sms' }.to_json
    end

    if @token && @alert.fire_status_event(@token.status_event)
      twiml = Twilio::TwiML::Response.new do |r|
        r.Sms "SOS##{@alert.id} has been #{@token.status_event}."
      end
    else
      twiml = Twilio::TwiML::Response.new do |r|
        r.Sms 'Command not understood.'
      end
    end
    render text: twiml.text
  end

  def phone
    puts params
    cookies[:notification_id] ||= params[:notification_id]
    @notification = Notification.find(cookies[:notification_id])
    @alert = @notification.alert
    phone_main
  end

  def phone_input
    puts params
    @notification = Notification.find(cookies[:notification_id])
    @alert = @notification.alert
    @alert.agent = @notification.user
    @alert.channel = { type: 'phone' }.to_json

    case params[:Digits]
    when 'TIMEOUT'
      phone_timeout
    when '4'
      phone_acknowledge
    when '6'
      phone_resolve
    when '0'
      phone_main
    else
      # TODO: handle invalid input
    end
  end

  private

  def phone_main
    @twiml = Twilio::TwiML::Response.new do |r|
      r.Pause length: 1
      r.Say ' You have received the following alert:'
      r.Say @alert.description
      r.Pause length: 1
      r.Say "Press 4 to acknowledge, press 6 to resolve, or press 0 to repeat."
      r.Gather(action: twilio_phone_input_path, numDigits: 1)
      r.Redirect "#{twilio_phone_input_path}?Digits=TIMEOUT"
    end
    render text: @twiml.text
  end

  def phone_timeout
    @twiml = Twilio::TwiML::Response.new do |r|
      r.Say 'Good bye!'
    end
    render text: @twiml.text
  end

  def phone_acknowledge
    @alert.acknowledged
    @twiml = Twilio::TwiML::Response.new do |r|
      r.Say 'The alert has been acknowledged, Good bye!'
    end
    render text: @twiml.text
  end

  def phone_resolve
    @alert.resolved
    @twiml = Twilio::TwiML::Response.new do |r|
      r.Say 'The alert has been resolved, Good bye!'
    end
    render text: @twiml.text
  end
end
