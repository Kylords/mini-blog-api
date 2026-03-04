# frozen_string_literal: true

module Mutations
  module Notification
    class ReadNotifications < Mutations::BaseMutation
      graphql_name 'ReadNotifications'

      argument :notification_ids, [ID], required: false

      field :user, Types::User, null: true

      def resolve(notification_ids:)
        authenticate_user!

        user = context[:current_user]

        notifications = user.notifications.where(
          id: notification_ids
        )

        notifications.update_all(read_at: Time.current)

        new_count = user.notifications.where(read_at: nil).count

        user.update!(
          unread_notifications_count: new_count
        )

        { user: user }
      end
    end
  end
end
