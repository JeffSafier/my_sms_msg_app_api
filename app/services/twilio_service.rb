# frozen_string_literal: true

class TwilioService

  def initialize
    @sid = Rails.application.credentials.twilio.fetch(:account_sid)
    @token = Rails.application.credentials.twilio.fetch(:auth_token)
    @phone = Rails.application.credentials.twilio.fetch(:phone_number)
    @client = Twilio::REST::Client.new(@sid, @token)

  end
  def send_sms_message(message)
    phone = message.phone_number
    if phone =~ /^\d/
      phone = "+1" + message.phone_number
    end
    @message = @client.messages&.create(to: phone, from: @phone, body: message.message)
  end
end
