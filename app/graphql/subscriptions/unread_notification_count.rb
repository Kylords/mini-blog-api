# frozen_string_literal: true

module Subscriptions
  class UnreadNotificationCount < Subscriptions::BaseSubscription
    argument :user_id, ID, required: true

    field :unread_notification_count, Int, null: true
    field :notification, Types::Notification, null: true

    def subscribe(user_id:)
      user = context[:current_user]
      return unless user

      {
        unread_notification_count: user.unread_notifications_count,
        notification: nil
      }
    end

    def update(user_id:)
      user = context[:current_user]
      return unless user

      user.reload

      {
        unread_notification_count: user.unread_notifications_count,
        notification: object[:notification]
      }
    end
  end
end
