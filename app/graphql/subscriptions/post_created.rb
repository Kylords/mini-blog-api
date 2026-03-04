# frozen_string_literal: true

module Subscriptions
  class PostCreated < Subscriptions::BaseSubscription
    field :post, Types::Post, null: true

    def subscribe
      OpenStruct.new(post: nil)
    end

    def update
      { post: object }
    end
  end
end
