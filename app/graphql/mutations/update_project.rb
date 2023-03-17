# frozen_string_literal: true

module Mutations
  # Mutation to update a project.
  class UpdateProject < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :status, String, required: false
    argument :description, String, required: false

    field :project, Types::ProjectType, null: false
    field :errors, [String], null: false

    def resolve(id:, title: nil, status: nil, description: nil)
      project = Project.find(id)

      if status.present? && project.status != status
        StatusChange.create(status: status, user: context[:current_user], project: project)
      end
      update_params = { title: title, status: status, description: description }.reject { |_, v| v.nil? }
      if project.update(update_params)
        { project: project, errors: [] }
      else
        { project: nil, errors: project.errors.full_messages }
      end
    end
  end
end
