# frozen_string_literal: true

class AddNotifiable < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :notifiable, polymorphic: true, index: true
  end
end
