# frozen_string_literal: true

module Mutations
  # Mutation to create a reply to a comment.
  class CreateReply < Mutations::BaseMutation
    argument :parent_comment_id, ID, required: true
    argument :content, String, required: true

    field :comment, Types::CommentType, null: true
    field :errors, [String], null: false

    def resolve(parent_comment_id:, content:)
      user = context[:current_user]
      parent_comment = Comment.find(parent_comment_id)
      reply = parent_comment.replies.new(user: user, content: content, project: parent_comment.project)

      if reply.save
        { comment: reply, errors: [] }
      else
        { comment: nil, errors: reply.errors.full_messages }
      end
    end
  end
end
