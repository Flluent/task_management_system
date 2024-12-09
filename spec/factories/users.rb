FactoryBot.define do
  factory :user do
    username { "TestUser" }
    password { "password" }
    password_confirmation { "password" }
  end
end