FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    lastname { 'qux' }
    password { "password@1234" }
    password_confirmation { "password@1234" }
  end
end
