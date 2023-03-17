# frozen_string_literal: true

module Types
  # GraphQL type for a Query.
  class QueryType < Types::BaseObject
    field :projects, [Types::ProjectType], null: false
    field :project, Types::ProjectType, null: true do
      argument :id, ID, required: true
    end

    def projects
      Project.all
    end

    def project(id:)
      Project.find(id)
    end
  end
end
