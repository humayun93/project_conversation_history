# frozen_string_literal: true

class CreateAllowlistedJwt < ActiveRecord::Migration[6.1]
  def change
    create_table :allowlisted_jwts do |t|
      t.string :jti
      t.datetime :expired_at

      t.timestamps
    end
    add_index :allowlisted_jwts, :jti
  end
end
