# frozen_string_literal: true

module Types
  # GraphQL type for a comment.
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :project, Types::ProjectType, null: false
    field :parent_comment, Types::CommentType, null: true
    field :replies, [Types::CommentType], null: true
    field :reactions, [Types::ReactionType], null: true
    field :content, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
