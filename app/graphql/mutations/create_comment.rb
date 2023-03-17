# frozen_string_literal: true

module Mutations
  # Mutation to create a comment.
  class CreateComment < Mutations::BaseMutation
    argument :project_id, ID, required: true
    argument :content, String, required: true

    field :comment, Types::CommentType, null: true
    field :errors, [String], null: false

    def resolve(project_id:, content:)
      user = context[:current_user]
      project = Project.find(project_id)
      comment = project.comments.new(user: user, content: content)

      if comment.save
        { comment: comment, errors: [] }
      else
        { comment: nil, errors: comment.errors.full_messages }
      end
    end
  end
end
