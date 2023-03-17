# frozen_string_literal: true

module Types
  # GraphQL type for a project.
  class ProjectType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :status, String, null: false
    field :description, String, null: true
    field :user, Types::UserType, null: false
    field :comments, [Types::CommentType], null: false
    field :status_changes, [Types::StatusChangeType], null: false
  end
end
