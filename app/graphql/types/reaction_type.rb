# frozen_string_literal: true

module Types
  # GraphQL type for a reaction.
  class ReactionType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :comment, Types::CommentType, null: false
    field :reaction_type, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
