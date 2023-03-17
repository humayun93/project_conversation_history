# frozen_string_literal: true

class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.integer :reaction_type

      t.timestamps
    end
  end
end
