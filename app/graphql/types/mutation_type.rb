# frozen_string_literal: true

module Types
  # GraphQL type for a mutations
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::RegisterUser
    field :sign_out_user, mutation: Mutations::SignOutUser
    field :sign_in_user, mutation: Mutations::SignInUser
    field :create_project, mutation: Mutations::CreateProject
    field :update_project, mutation: Mutations::UpdateProject
    field :create_comment, mutation: Mutations::CreateComment
    field :create_reply, mutation: Mutations::CreateReply
    field :create_reaction, mutation: Mutations::CreateReaction
  end
end
