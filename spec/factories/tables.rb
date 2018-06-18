FactoryBot.define do
  factory :table do
    name Faker::Internet.password
  end
end
