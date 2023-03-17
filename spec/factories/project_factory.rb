# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    title { Faker::Lorem.word }
    status { :pending }
    description { Faker::Lorem.sentence }
    association :user
  end
end
