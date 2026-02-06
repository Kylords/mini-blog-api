# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    multiple_fields Types::QueryFields::User,
                    Types::QueryFields::Post,
                    Types::QueryFields::Comment
  end
end
