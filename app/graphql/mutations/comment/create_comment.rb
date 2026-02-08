# frozen_string_literal: true

module Mutations
  module Comment
    class CreateComment < Mutations::BaseMutation
      graphql_name 'CreateComment'

      argument :post_id, ID, required: true
      argument :body, String, required: true

      field :comment, Types::Comment, null: false

      def resolve(post_id:, body:)
        authenticate_user!

        user = context[:current_user]
        user_id = user.id
        comment = ::Comment.create!(
          user_id: user_id,
          post_id: post_id,
          body: body
        )

        # post = ::Post.find(post_id)

        # comment_count = post.comments_count

        # require 'pry'; binding.pry
        # ::PracticeSchema.subscriptions.trigger(
        #   :comment_count,
        #   { post_id: post_id },
        #   comment_count: comment_count
        # )

        # notification_count = user.unread_notifications_count

        # post_user_id = ::Post.find(post_id).user_id
        # Notification.create!(
        #   user_id: post_user_id,
        #   message: "#{user.name} has commented on your post."
        # )

        # ::PracticeSchema.subscriptions.trigger(
        #   :notification_count,
        #   { user_id: user_id },
        #   notification_count: notification_count
        # )

        { comment: comment }
      end
    end
  end
end
