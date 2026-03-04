# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    multiple_fields Types::MutationFields::User,
                    Types::MutationFields::Comment,
                    Types::MutationFields::Post,
                    Types::MutationFields::Notification
  end
end
