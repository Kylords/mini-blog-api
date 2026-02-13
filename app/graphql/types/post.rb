# frozen_string_literal: true

module Types
  class Post < Types::BaseObject
    field :id, ID, null: false
    field :body, String, null: false
    field :title, String, null: false
    field :user, Types::User, null: false
    field :user_id, ID, null: false
    field :comments, [Types::Comment], null: true
    field :visible_comments, Types::Comment.connection_type, null: true do
      argument :first, Int, required: false, default_value: 10
      argument :after, String, required: false
    end
    field :user, Types::User, null: false

    field :comment_count, Int, null: false

    def comment_count
      object.comments.visible.count
    end

    def visible_comments(**_args)
      object.comments.visible.order(created_at: :asc)
    end

    def body
      ActionController::Base.helpers.sanitize(
        object.body, tags: [],  attributes: []
      )
    end

    def title
      ActionController::Base.helpers.sanitize(
        object.title, tags: [], attributes: []
      )
    end
  end
end
