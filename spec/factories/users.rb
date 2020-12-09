FactoryBot.define do
  factory :user do
    account_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'aaaaaa' }
  end
end
