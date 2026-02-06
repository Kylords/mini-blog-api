# frozen_string_literal: true

module Types
  module QueryFields
    class User < Types::BaseObject
      field :users, [Types::User], null: false

      field :user,
            Types::User,
            null: true do
              argument :user_id,
                       ID,
                       required: true
            end

      field :search_users,
            [Types::User],
            null: true do
              argument :query,
                       String,
                       required: true
            end

      Types::QueryType.class_eval do
        def users
          ::User.visible
        end

        def user(user_id:)
          ::User.visible.find(user_id)
        rescue ActiveRecord::RecordNotFound
          nil
        end

        def search_users(query:)
          return User.none if query.blank?

          users = ::User.visible.where(
            'LOWER(name) LIKE :q OR LOWER(email) LIKE :q',
            q: "%#{query.downcase}%"
          ).distinct

          users.order(name: :asc)
        end
      end
    end
  end
end
