# frozen_string_literal: true

# Comment represents a user's input on a project.
# Comments can be replies to other comments, forming a threaded conversation.
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :parent_comment, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_comment_id, dependent: :destroy
  has_many :reactions, dependent: :destroy

  validates :content, presence: true
end
