# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::SignInUser, type: :request do
  let!(:user) { create(:user, password: 'password123', password_confirmation: 'password123') }

  describe 'sign in user' do
    let(:query) do
      <<-GQL
        mutation {
          signInUser(input: { email: "#{email}", password: "#{password}" }) {
            token
            user {
              id
              email
            }
            errors
          }
        }
      GQL
    end

    subject { post '/graphql', params: { query: query } }
    let(:response_data) { JSON.parse(response.body)['data']['signInUser'] }

    context 'with valid credentials' do
      let(:email) { user.email }
      let(:password) { 'password123' }

      it 'returns the user and token' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response_data['user']['id']).to eq(user.id.to_s)
        expect(response_data['user']['email']).to eq(user.email)
        expect(response_data['token']).not_to be_nil
        expect(response_data['errors']).to be_empty
      end
    end

    context 'with invalid credentials' do
      let(:email) { user.email }
      let(:password) { 'wrong_password' }

      it 'returns errors' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response_data['user']).to be_nil
        expect(response_data['token']).to be_nil
        expect(response_data['errors']).not_to be_empty
      end
    end
  end
end
