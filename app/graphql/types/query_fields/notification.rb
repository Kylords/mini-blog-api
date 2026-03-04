# frozen_string_literal: true

module Types
  module QueryFields
    class Notification < Types::BaseObject
      field :notifications, Types::Notification.connection_type, null: true

      Types::QueryType.class_eval do
        def notifications
          return unless context[:current_user]

          ::Notification.where(user_id: context[:current_user].id).order(created_at: :desc)
        end
      end
    end
  end
end
