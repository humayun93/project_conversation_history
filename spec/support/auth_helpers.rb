# frozen_string_literal: true

module AuthHelpers
  def auth_headers_for(user)
    jti = SecureRandom.uuid
    expiration_time = Time.now.to_i + 1.day.to_i
    payload = { sub: user.id, jti: jti, exp: expiration_time }
    token = JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')

    AllowlistedJwt.create(jti: jti, expired_at: Time.at(expiration_time))
    {
      'Authorization' => "Bearer #{token}"
    }
  end
end
