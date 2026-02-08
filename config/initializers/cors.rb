# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173' # your frontend URL

    resource '/graphql',
             headers: :any,
             methods: %i[get post options]
  end
end
