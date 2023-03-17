# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateProject, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }

    it 'successfully creates a project' do
      post '/graphql', params: {
        query: <<~GRAPHQL
          mutation {
            createProject(input: { title: "New Project", status: "active" }) {
              project {
                id
                title
                status
              }
              errors
            }
          }
        GRAPHQL
      }, headers: auth_headers_for(user)

      json = JSON.parse(response.body)
      project_data = json['data']['createProject']['project']

      expect(project_data['title']).to eq('New Project')
      expect(project_data['status']).to eq('active')
      expect(json['data']['createProject']['errors']).to be_empty
    end
  end
end
