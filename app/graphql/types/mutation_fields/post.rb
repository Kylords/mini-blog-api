# frozen_string_literal: true

module Types
  module MutationFields
    class Post < Types::BaseObject
      field :create_post, mutation: Mutations::Post::CreatePost

      field :edit_post, mutation: Mutations::Post::EditPost

      field :delete_post, mutation: Mutations::Post::DeletePost
    end
  end
end
