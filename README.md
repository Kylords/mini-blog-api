# Mini Blog API (Backend)

## Project Overview
I chose to build a Mini Blog API as a real-world project to demonstrate full-stack development skills. While it doesn’t solve a unique problem, it showcases essential web application features such as user authentication, CRUD operations, real-time updates via subscriptions, and secure handling of user data. This project provides a practical example of modern web applications and highlights my abilities in both backend and frontend development.

## Tech Stack
- Ruby 2.5.3
- Rails 5.2.8
- GraphQL (graphql-ruby)
- Action Cable (WebSockets)
- RSpec (testing)
- bcrypt (password hashing)
- JWT (authentication)

## Installation & Setup
1. Clone the repository: git clone <backend-repo-link>
2. Navigate to the project directory: cd mini-blog-api
3. Install dependencies: bundle install
4. Create and setup the database: rails db:create db:migrate
5. Set environment variables in .env:
   - JWT_SECRET=<your-secret-key>
6. Start the Rails server: rails s
7. Access the GraphQL playground at http://localhost:3000/graphiql

## Authentication
- Users are authenticated using JWT.

## Features
- CRUD operations for posts and users
- User authentication (signup/login with JWT)
- Real-time subscription **demo**: when a user creates a new post, all logged-in users see the new post appear at the top of their post list in real time
- Basic form validation and error handling
- Password hashing using bcrypt

## Testing
- Unit tests are written using RSpec
- Run tests: bundle exec rspec
- Example tests include:
  - Validating presence of email and password for users
  - Checking email uniqueness
  - Password confirmation validation

## Security & Best Practices
- Passwords are hashed with bcrypt
- GraphQL input is validated to prevent malicious queries
- User-generated content is sanitized (in app/graphql/types/post.rb and app/graphql/types/comment.rb)

## Git & Branching Strategy
- Git is used for version control
- develop branch is used for active development
- main branch contains stable production-ready code
- Make meaningful commits with descriptive messages for every feature or fix
