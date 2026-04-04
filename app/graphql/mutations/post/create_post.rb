# frozen_string_literal: true

module Mutations
  module Post
    class CreatePost < Mutations::BaseMutation
      graphql_name 'CreatePost'

      argument :title, String, required: true
      argument :body, String, required: true

      field :post, Types::Post, null: false
      field :errors, [String], null: true

      def resolve(title:, body:)
        authenticate_user!

        post = nil

        ActiveRecord::Base.transaction do
          user_id = context[:current_user].id

          post = ::Post.create!(
            user_id: user_id,
            title: title,
            body: body
          )

          summary = AiSummaryService.generate_summary(
            content: post.body,
            title: post.title
          )

          post.update!(summary: summary)
        end

        MiniBlogApiSchema.subscriptions.trigger(:post_created, {}, post)

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
