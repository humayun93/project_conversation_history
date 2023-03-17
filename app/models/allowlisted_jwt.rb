# frozen_string_literal: true

class AllowlistedJwt < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist
end
