# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    def self.multiple_fields(*args)
      args.each { |klass| klass.fields.values.each { |field| add_field field } }
    end
  end
end
