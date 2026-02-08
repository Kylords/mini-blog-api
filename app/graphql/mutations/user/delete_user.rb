# frozen_string_literal: true

module Mutations
  module User
    class DeleteUser < Mutations::BaseMutation
      graphql_name 'DeleteUser'

      argument :user_id, ID, required: true

      field :user, Types::User, null: false

      def resolve(user_id:)
        current_user?(user_id: user_id)
        user = ::User.find(user_id)
        raise GraphQL::ExecutionError, 'User not Found' unless user

        user = user.update!(hidden: true)

        { user: user }
      end
    end
  end
end
