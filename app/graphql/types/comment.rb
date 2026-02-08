# frozen_string_literal: true

module Types
  class Comment < Types::BaseObject
    field :id, ID, null: false
    field :body, String, null: false
    field :user, Types::User, null: false
    field :user_id, ID, null: false
    field :post, Types::Post, null: false
    field :post_id, ID, null: false

    def body
      ActionController::Base.helpers.sanitize(
        object.body, tags: [], attributes: []
      )
    end
  end
end
