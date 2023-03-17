# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    association :user
    association :project

    factory :reply do
      association :parent_comment, factory: :comment
    end
  end
end
