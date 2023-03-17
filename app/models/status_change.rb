# frozen_string_literal: true

# StatusChange represents a change in the status of a project.
# It keeps track of the user who made the change and the new status of the project.
class StatusChange < ApplicationRecord
  belongs_to :user
  belongs_to :project
end
