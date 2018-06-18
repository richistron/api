FactoryBot.define do
  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password
    nickname Faker::Internet.name
  end
end
