# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, as: :notifiable

  validates :body, presence: true

  # Hidden is for soft deleting models
  # Scope to fetch only "visible" records
  scope :visible, -> { where(hidden: [false, nil]) }
end
