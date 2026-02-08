# frozen_string_literal: true

module Types
  module MutationFields
    class Comment < Types::BaseObject
      field :create_comment, mutation: Mutations::Comment::CreateComment
      field :edit_comment, mutation: Mutations::Comment::EditComment
      field :delete_comment, mutation: Mutations::Comment::DeleteComment
    end
  end
end
