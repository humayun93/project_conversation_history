# frozen_string_literal: true

module Types
  # GraphQL type for a status change.
  class StatusChangeType < Types::BaseObject
    field :id, ID, null: false
    field :status, String, null: false
    field :user, Types::UserType, null: false
    field :project, Types::ProjectType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
