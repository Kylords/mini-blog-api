# frozen_string_literal: true

module Mutations
  module User
    class CreateUser < Mutations::BaseMutation
      graphql_name 'CreateUser'

      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      field :token, String, null: true
      field :user, Types::User, null: true
      field :errors, [String], null: true

      def resolve(name:, email:, password:, password_confirmation:)
        user = ::User.create!(
          name: name,
          email: email,
          password: password,
          password_confirmation: password_confirmation
        )

        token = JsonWebToken.encode(user_id: user.id)

        {
          token: token,
          user: user,
          errors: []
        }
      rescue ActiveRecord::RecordInvalid => e
        {
          token: nil,
          user: nil,
          errors: e.record.errors.full_messages
        }
      end
    end
  end
end
