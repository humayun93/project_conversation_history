# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::RegisterUser, type: :request do
  describe '.resolve' do
    context 'with valid attributes' do
      it 'successfully registers a user' do
        post '/graphql', params: {
          query: <<~GRAPHQL
            mutation {
              registerUser(input: { name: "John Doe", email: "john@example.com", password: "password123", passwordConfirmation: "password123" }) {
                user {
                  id
                  name
                  email
                }
                errors
              }
            }
          GRAPHQL
        }

        json = JSON.parse(response.body)

        register_user_data = json['data']['registerUser']

        expect(register_user_data['user']['name']).to eq('John Doe')
        expect(register_user_data['user']['email']).to eq('john@example.com')
        expect(register_user_data['errors']).to be_empty
      end
    end

    context 'with invalid attributes' do
      it 'returns errors for invalid email' do
        post '/graphql', params: {
          query: <<~GRAPHQL
            mutation {
              registerUser(input: { name: "John Doe", email: "invalid_email", password: "password123", passwordConfirmation: "password123" }) {
                user {
                  id
                  name
                  email
                }
                errors
              }
            }
          GRAPHQL
        }

        json = JSON.parse(response.body)
        register_user_data = json['data']['registerUser']

        expect(register_user_data['user']).to be_nil
        expect(register_user_data['errors']).to include('Email is invalid')
      end
    end
  end
end
