# frozen_string_literal: true

FactoryBot.define do
  factory :allowlisted_jwt do
    jti { SecureRandom.uuid }
    expired_at { 1.day.from_now }
  end
end
