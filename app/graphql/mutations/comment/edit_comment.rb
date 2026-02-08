# frozen_string_literal: true

module Mutations
  module Comment
    class EditComment < Mutations::BaseMutation
      graphql_name 'EditComment'

      argument :comment_id, ID, required: true
      argument :body, String, required: true

      field :comment, Types::Comment, null: false
      field :errors, [String], null: true

      def resolve(comment_id:, body:)
        comment = ::Comment.find(comment_id)
        current_user?(user_id: comment.user_id)

        comment.update!(
          body: body
        )

        { comment: comment, errors: [] }
      rescue ActiveRecord::RecordInvalid => e
        {
          comment: nil,
          errors: e.record.errors.full_messages
        }
      end
    end
  end
end
