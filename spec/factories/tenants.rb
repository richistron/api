FactoryBot.define do
  factory :tenant do
    name Faker::Internet.password
  end
end
