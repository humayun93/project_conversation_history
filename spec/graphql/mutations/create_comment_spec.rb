# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateComment, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }

    it 'successfully creates a comment' do
      post '/graphql', params: {
        query: <<~GRAPHQL
          mutation {
            createComment(input: { projectId: "#{project.id}", content: "New comment" }) {
              comment {
                id
                content
              }
              errors
            }
          }
        GRAPHQL
      }, headers: auth_headers_for(user)

      json = JSON.parse(response.body)
      comment_data = json['data']['createComment']['comment']

      expect(comment_data['content']).to eq('New comment')
      expect(json['data']['createComment']['errors']).to be_empty
    end
  end
end
