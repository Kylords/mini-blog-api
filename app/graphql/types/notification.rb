# frozen_string_literal: true

module Types
  class Notification < Types::BaseObject
    field :id, ID, null: false
    field :message, String, null: false
    field :read_at, GraphQL::Types::ISO8601DateTime, null: true
    field :user_id, ID, null: false
    field :user, Types::User, null: false
    field :notifiable, Types::NotifiableUnion, null: true
  end
end
