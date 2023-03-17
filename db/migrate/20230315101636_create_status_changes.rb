# frozen_string_literal: true

class CreateStatusChanges < ActiveRecord::Migration[6.1]
  def change
    create_table :status_changes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
