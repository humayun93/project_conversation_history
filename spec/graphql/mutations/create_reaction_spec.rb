# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateReaction, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:comment) { create(:comment, user: user, project: project) }

    it 'successfully creates a reaction' do
      post '/graphql', params: {
        query: <<~GRAPHQL
          mutation {
            createReaction(input: { commentId: "#{comment.id}", reactionType: "like" }) {
              reaction {
                id
                reactionType
              }
              errors
            }
          }
        GRAPHQL
      }, headers: auth_headers_for(user)

      json = JSON.parse(response.body)
      reaction_data = json['data']['createReaction']['reaction']

      expect(reaction_data['reactionType']).to eq('like')
      expect(json['data']['createReaction']['errors']).to be_empty
    end
  end
end
