# frozen_string_literal: true

module Subscriptions
  class PostCreated < Subscriptions::BaseSubscription
    field :post, Types::Post, null: true

    # Called when the client subscribes
    def subscribe
      # You can return nothing here or nil
      OpenStruct.new(post: nil)
    end

    # Called when you trigger the subscription
    def update
      { post: object }
    end
  end
end
