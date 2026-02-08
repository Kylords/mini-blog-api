# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # Hidden is for soft deleting models
  # Scope to fetch only "visible" records
  scope :visible, -> { where(hidden: [false, nil]) }
end
