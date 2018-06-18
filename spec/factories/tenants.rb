FactoryBot.define do
  factory :tenant do
    name Faker::Internet.password
    application 'RESTAURANT'
  end
end
