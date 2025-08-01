# frozen_string_literal: true

class WebTokenManagement
  SECRET_KEY = Rails.application.credentials.fetch(:devise_jwt_secret_key)

  def self.encode_token(payload, exp = 2.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end
  def self.decode_token(token)
    user_hsh = JWT.decode(token, SECRET_KEY).first
    HashWithIndifferentAccess.new(user_hsh)



  end
end
