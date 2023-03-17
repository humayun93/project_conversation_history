# frozen_string_literal: true

module Mutations
  # Mutation to create a new project.
  class CreateProject < Mutations::BaseMutation
    argument :title, String, required: true
    argument :status, String, required: false

    field :project, Types::ProjectType, null: false
    field :errors, [String], null: false

    def resolve(title:, status: nil)
      user = context[:current_user] || User.first

      project = user.projects.build(title: title, status: status)

      if project.save
        StatusChange.create(status: status, user: context[:current_user], project: project)
        { project: project, errors: [] }
      else
        { project: nil, errors: project.errors.full_messages }
      end
    end
  end
end
