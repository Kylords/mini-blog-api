# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.timestamp :read_at
      t.text :message
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
