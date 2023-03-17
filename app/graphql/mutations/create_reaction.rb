# frozen_string_literal: true

module Mutations
  # Mutation to create a reaction.
  class CreateReaction < Mutations::BaseMutation
    argument :comment_id, ID, required: true
    argument :reaction_type, String, required: true

    field :reaction, Types::ReactionType, null: true
    field :errors, [String], null: false

    def resolve(comment_id:, reaction_type:)
      user = context[:current_user]
      comment = Comment.find(comment_id)
      reaction = comment.reactions.new(user: user, reaction_type: reaction_type)

      if reaction.save
        { reaction: reaction, errors: [] }
      else
        { reaction: nil, errors: reaction.errors.full_messages }
      end
    end
  end
end
