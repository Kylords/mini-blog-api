# frozen_string_literal: true

class AddHiddenToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :hidden, :boolean, default: false, null: false
  end
end
