# frozen_string_literal: true

require 'rails_helper'

# Run 'bundle exec rspec' to run the unit test
RSpec.describe User, type: :model do
  # Test 1: email presence
  it 'is invalid without an email' do
    user = User.new(password: '123456', name: 'Test User')
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  # Test 2: password presence
  it 'is invalid without a password' do
    user = User.new(email: 'test@example.com', name: 'Test User')
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("can't be blank")
  end

  # Test 3: email uniqueness
  it 'is invalid with a duplicate email' do
    User.create!(email: 'test@example.com', password: '123456', name: 'Existing User')
    user2 = User.new(email: 'test@example.com', password: 'abcdef', name: 'Another User')
    expect(user2).not_to be_valid
    expect(user2.errors[:email]).to include('has already been taken')
  end

  # Test 4: valid user
  it 'is valid with valid attributes' do
    user = User.new(
      email: 'unique@example.com',
      password: '123456',
      password_confirmation: '123456',
      name: 'Valid User'
    )
    expect(user).to be_valid
  end

  # Test 5: password confirmation
  it 'is invalid if password and password_confirmation do not match' do
    user = User.new(
      email: 'user@example.com',
      password: '123456',
      password_confirmation: 'abcdef',
      name: 'Test User'
    )
    expect(user).not_to be_valid
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end
end
