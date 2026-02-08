# frozen_string_literal: true

module Mutations
  module Post
    class DeletePost < Mutations::BaseMutation
      graphql_name 'DeletePost'

      argument :post_id, ID, required: true

      field :post, Types::Post, null: false
      field :errors, [String], null: true

      def resolve(post_id:)
        post = ::Post.find(post_id)
        current_user?(user_id: post.user_id)

        post.update!(hidden: true)

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
