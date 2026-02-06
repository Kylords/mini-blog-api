# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  # Hidden is for soft deleting models
  # Scope to fetch only "visible" records
  scope :visible, -> { where(hidden: false) }
end
