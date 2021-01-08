FactoryBot.define do
  factory :user do
    name { "factory" }
    sequence(:email) { |n| "factory#{n}@example.com" }
    password { "password" }
  end
end
