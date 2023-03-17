# frozen_string_literal: true

# Reaction represents a user's reaction to a comment (like or dislike).
class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  enum reaction_type: { like: 0, dislike: 1 }

  validates :reaction_type, presence: true
  validates :user_id, uniqueness: { scope: :comment_id, message: 'can only react once per comment' }
end
