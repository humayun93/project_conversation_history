# frozen_string_literal: true

# Project represents a work item that has a title, status, and associated comments and status changes.
class Project < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :status_changes
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  enum status: { pending: 0, active: 1, done: 2, inactive: 3 }
end
