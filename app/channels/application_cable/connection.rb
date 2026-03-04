# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def token
      request.params[:token]
    end

    def find_verified_user
      token_value = token
      return reject_unauthorized_connection if token_value.blank?

      payload = JsonWebToken.decode(token_value)
      return reject_unauthorized_connection unless payload

      user = User.find_by(id: payload['user_id'])
      return reject_unauthorized_connection unless user

      user
    end
  end
end
