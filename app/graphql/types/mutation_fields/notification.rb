# frozen_string_literal: true

module Types
  module MutationFields
    class Notification < Types::BaseObject
      field :read_notifications,
            mutation: Mutations::Notification::ReadNotifications
    end
  end
end
