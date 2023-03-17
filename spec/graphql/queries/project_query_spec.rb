# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphQL API', type: :request do
  let!(:user) { create(:user) }
  describe 'projects query' do
    let!(:projects) { create_list(:project, 3) }

    let(:query) do
      <<-GRAPHQL
        query {
          projects {
            id
            title
            status
          }
        }
      GRAPHQL
    end

    it 'returns all projects' do
      post '/graphql', params: { query: query }, headers: auth_headers_for(user)
      json_response = JSON.parse(response.body)

      expect(json_response.dig('data', 'projects').length).to eq(3)
      expect(json_response.dig('data', 'projects')).to match_array(
        projects.map do |project|
          {
            'id' => project.id.to_s,
            'title' => project.title,
            'status' => project.status
          }
        end
      )
    end
  end

  describe 'project query' do
    let!(:project) { create(:project) }

    let(:query) do
      <<-GRAPHQL
        query($id: ID!) {
          project(id: $id) {
            id
            title
            status
          }
        }
      GRAPHQL
    end

    it 'returns a project by ID' do
      post '/graphql', params: { query: query, variables: { id: project.id.to_s } }, headers: auth_headers_for(user)
      json_response = JSON.parse(response.body)

      expect(json_response.dig('data', 'project')).to eq(
        'id' => project.id.to_s,
        'title' => project.title,
        'status' => project.status
      )
    end
  end
end
