# frozen_string_literal: true

module Mutations
  module Comment
    class DeleteComment < Mutations::BaseMutation
      graphql_name 'DeleteComment'

      argument :comment_id, ID, required: true

      field :comment, Types::Comment, null: false
      field :errors, [String], null: true

      def resolve(comment_id:)
        comment = ::Comment.find(comment_id)
        current_user?(user_id: comment.user_id)

        comment.update!(hidden: true)

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
