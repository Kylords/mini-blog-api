# frozen_string_literal: true

module Types
  module QueryFields
    class User < Types::BaseObject
      field :users, Types::User.connection_type, null: false

      field :user,
            Types::User,
            null: true do
              argument :user_id,
                       ID,
                       required: true
            end

      field :search_users,
            Types::User.connection_type,
            null: true do
              argument :query,
                       String,
                       required: false
            end

      Types::QueryType.class_eval do
        def users
          ::User.visible.order(created_at: :desc)
        end

        def user(user_id:)
          ::User.visible.find(user_id)
        rescue ActiveRecord::RecordNotFound
          nil
        end

        def search_users(query:)
          # require 'pry'; binding.pry
          # return nil if query.blank?

          users = ::User.visible.where(
            'LOWER(name) LIKE :q',
            q: "%#{query.downcase}%"
          ).distinct

          users.order(name: :asc)
        end
      end
    end
  end
end
