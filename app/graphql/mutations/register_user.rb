# frozen_string_literal: true

module Mutations
  # Mutation to register a new user.
  class RegisterUser < Mutations::BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(name:, email:, password:, password_confirmation:)
      user = User.new(name: name, email: email, password: password, password_confirmation: password_confirmation)

      if user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
