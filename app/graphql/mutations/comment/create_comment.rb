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

        post = ::Post.find(post_id)
        post_user = post.user

        if post_user.id != user.id
          notification = post_user.create_notification(
            message: "#{user.name} commented on your Post: #{post.title}",
            notifiable: comment
          )

          # MiniBlogApiSchema.subscriptions.trigger(
          #   :unread_notification_count,
          #   { user_id: post_user.id },
          #   scope: post_user.id
          # )

          MiniBlogApiSchema.subscriptions.trigger(
            :unread_notification_count,
            {
              user_id: post_user.id
            },
            notification: notification
            # scope: post_user.id
          )
        end

        { comment: comment }
      end
    end
  end
end
