# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    # Use a sequence to ensure emails are always unique
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password123" }
  end
end