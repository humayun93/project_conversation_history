# frozen_string_literal: true

module Types
  # GraphQL type for a user.
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
  end
end