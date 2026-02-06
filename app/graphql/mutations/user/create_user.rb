# frozen_string_literal: true

module Mutations
  module User
    class CreateUser < Mutations::BaseMutation
      graphql_name 'CreateUser'

      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      field :user, Types::User, null: false

      def resolve(name:, email:, password:, password_confirmation:)
        #
        # USING THE "!" OPERATOR AUTOMATICALLY GIVES ERRORS
        user = ::User.create!(
          name: name,
          email: email,
          password: password,
          password_confirmation: password_confirmation
        )

        { user: user }

        #
        # ALTERNATIVE WAY FOR CREATE USER WITH ERROR
        # WITHOUT USING "!" OPERATOR
        #
        # user = ::User.new(
        #   name: name,
        #   email: email,
        #   password: password,
        #   password_confirmation: password_confirmation
        # )

        # if user.save
        #   { user: user, errors: [] }
        # else
        #   { user: nil, errors: user.errors.full_messages }
        # end
      end
    end
  end
end
