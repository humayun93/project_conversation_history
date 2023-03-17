# frozen_string_literal: true

# Application controller to be inherited by all controllers.
class ApplicationController < ActionController::API
  before_action :authenticate_user!, unless: :graphql_public_endpoint?

  private

  def authenticate_user!
    token = auth_token
    return unauthorized_error if token.nil?

    decoded_token = decode_auth_token(token)
    return unauthorized_error unless valid_jwt?(decoded_token)

    user_id = get_user_id(decoded_token)
    update_current_user(user_id)
  rescue JWT::DecodeError
    invalid_token_error
  end

  def auth_token
    request.headers['Authorization']&.split('Bearer ')&.last
  end

  def decode_auth_token(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' }).first
  end

  def valid_jwt?(decoded_token)
    jti = decoded_token['jti']
    jwt = AllowlistedJwt.find_by(jti: jti)
    jwt.present? && jwt.expired_at > Time.now
  end

  def get_user_id(decoded_token)
    decoded_token['sub']
  end

  def unauthorized_error
    render json: { errors: ['Unauthorized'] }, status: :unauthorized
  end

  def invalid_token_error
    render json: { errors: ['Invalid token'] }, status: :unauthorized
  end

  def update_current_user(user_id)
    @current_user = User.find(user_id)
  end

  def graphql_public_endpoint?
    return false unless params[:query].present?

    public_operations = %w[signInUser registerUser IntrospectionQuery]
    public_operations.any? do |operation|
      request.params[:query].include?(operation)
    end
  end
end
