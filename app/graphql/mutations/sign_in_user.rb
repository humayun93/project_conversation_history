# frozen_string_literal: true

module Mutations
  # Mutation to sign in a user.
  class SignInUser < Mutations::BaseMutation
    null true

    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:)
      user = User.find_for_authentication(email: email)

      return { errors: ['Invalid email or password'] } unless user.present? && user.valid_password?(password)

      jti = SecureRandom.uuid
      expiration_time = Time.now.to_i + 1.day.to_i

      payload = { sub: user.id, jti: jti, exp: expiration_time }
      token = JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')

      AllowlistedJwt.create(jti: jti, expired_at: Time.at(expiration_time))

      { user: user, token: token, errors: [] }
    end
  end
end
