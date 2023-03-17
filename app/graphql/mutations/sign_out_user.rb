# frozen_string_literal: true

module Mutations
  # Mutation to sign out a user.
  class SignOutUser < BaseMutation
    field :success, Boolean, null: false

    def resolve
      current_user = context[:current_user]

      return { success: false } unless current_user

      token = auth_token(context[:request])
      if token
        decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true,
                                   { algorithm: 'HS256' }).first
        jti = decoded_token['jti']

        AllowlistedJwt.find_by(jti: jti)&.delete
      end

      { success: true }
    end

    def auth_token(_request)
      auth_header = context[:request]&.headers&.[]('Authorization')
      auth_header&.split('Bearer ')&.last
    end
  end
end
