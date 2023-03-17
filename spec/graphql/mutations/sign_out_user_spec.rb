# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::SignOutUser, type: :request do
  let!(:user) { create(:user) }
  let(:jti) { SecureRandom.uuid }
  let(:token) do
    # Generate a valid JWT for the user
    expiration_time = Time.now.to_i + 1.day.to_i
    payload = { sub: user.id, jti: jti, exp: expiration_time }
    JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
  end
  let!(:allowlisted_jwt) { create(:allowlisted_jwt, jti: jti) }

  describe 'sign out user' do
    let(:query) do
      <<-GQL
        mutation {
          signOutUser(input: {}) {
            success
          }
        }
      GQL
    end

    subject { post '/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{token}" } }
    let(:response_data) { JSON.parse(response.body)['data']['signOutUser'] }

    context 'when user is signed in' do
      it 'returns success true and removes the allowlisted jwt' do
        expect { subject }.to change { AllowlistedJwt.count }.by(-1)
        expect(response).to have_http_status(:ok)
        expect(response_data['success']).to be_truthy
      end
    end

    context 'when user is not signed in' do
      let(:token) { '' }

      it 'returns success false and does not remove any allowlisted jwt' do
        expect { subject }.not_to change { AllowlistedJwt.count }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
