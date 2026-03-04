# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  ALLOWED_NOTIFIABLE_TYPES = %w[Comment].freeze

  after_create_commit :increment_unread
  after_update_commit :handle_read_at_change
  after_destroy_commit :decrement_unread_if_unread

  validates :notifiable_type, inclusion: {
    in: ALLOWED_NOTIFIABLE_TYPES
  }

  private

  def unread?
    read_at.nil?
  end

  def increment_unread
    return unless unread?

    user.increment!(:unread_notifications_count)
  end

  def handle_read_at_change
    return unless saved_change_to_read_at?

    if read_at.present?
      user.decrement!(:unread_notifications_count)
    else
      user.increment!(:unread_notifications_count)
    end
  end

  def decrement_unread_if_unread
    return unless unread?

    user.decrement!(:unread_notifications_count)
  end
end
