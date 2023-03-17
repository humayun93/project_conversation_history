# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateReply, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:comment) { create(:comment, user: user, project: project) }

    it 'successfully creates a reply' do
      post '/graphql', params: {
        query: <<~GRAPHQL
          mutation {
            createReply(input: { parentCommentId: "#{comment.id}", content: "New reply" }) {
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
      reply_data = json['data']['createReply']['comment']

      expect(reply_data['content']).to eq('New reply')
      expect(json['data']['createReply']['errors']).to be_empty
    end
  end
end
