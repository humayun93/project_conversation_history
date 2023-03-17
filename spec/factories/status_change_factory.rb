# frozen_string_literal: true

FactoryBot.define do
  factory :status_change do
    user
    project
    status { Project.statuses.keys.sample }
  end
end
