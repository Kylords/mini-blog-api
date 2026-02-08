# frozen_string_literal: true

module Mutations
  module Post
    class EditPost < Mutations::BaseMutation
      graphql_name 'EditPost'

      argument :post_id, ID, required: true
      argument :title, String, required: true
      argument :body, String, required: true

      field :post, Types::Post, null: false
      field :errors, [String], null: true

      def resolve(post_id:, title:, body:)
        post = ::Post.find(post_id)
        current_user?(user_id: post.user_id)

        post.update!(
          title: title,
          body: body
        )

        { post: post, errors: [] }
      rescue ActiveRecord::RecordInvalid => e
        {
          post: nil,
          errors: e.record.errors.full_messages
        }
      end
    end
  end
end
