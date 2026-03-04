# frozen_string_literal: true

module Types
  class SubscriptionType < Types::BaseObject
    extend GraphQL::Subscriptions::SubscriptionRoot

    field :post_created, subscription: Subscriptions::PostCreated

    field :unread_notification_count, subscription: Subscriptions::UnreadNotificationCount
  end
end
