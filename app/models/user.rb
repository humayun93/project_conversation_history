# frozen_string_literal: true

# User represents an individual who can interact with the system by creating projects
# , leaving comments, and changing project status.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: AllowlistedJwt

  has_many :projects
  has_many :comments
  has_many :status_changes
  has_many :reactions
end
