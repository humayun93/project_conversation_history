# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UpdateProject, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user, title: 'Old Project', status: 'inactive', description: 'test') }

    context 'when updating the project status' do
      it 'successfully updates a project and creates a status change record' do
        expect do
          post '/graphql', params: {
            query: <<~GRAPHQL
              mutation {
                updateProject(input: { id: "#{project.id}", status: "active" }) {
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
        end.to change { StatusChange.count }.by(1)

        json = JSON.parse(response.body)
        
        project_data = json['data']['updateProject']['project']
        
        expect(project_data['title']).to eq('Old Project')
        expect(project_data['status']).to eq('active')
        expect(json['data']['updateProject']['errors']).to be_empty
      end
    end

    context 'when not updating the project status' do
      it 'successfully updates a project without creating a status change record' do
        expect do
          post '/graphql', params: {
            query: <<~GRAPHQL
              mutation {
                updateProject(input: { id: "#{project.id}", title: "Updated Project" }) {
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
        end.not_to change { StatusChange.count }
        
        json = JSON.parse(response.body)
        project_data = json['data']['updateProject']['project']

        expect(project_data['title']).to eq('Updated Project')
        expect(project_data['status']).to eq('inactive')
        expect(json['data']['updateProject']['errors']).to be_empty
      end
    end
  end
end
