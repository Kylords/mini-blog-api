# frozen_string_literal: true

class AddHiddenToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :hidden, :boolean, default: false, null: false
  end
end
