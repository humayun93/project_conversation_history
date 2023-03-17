# frozen_string_literal: true

class AddStatusToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :status, :integer
  end
end
