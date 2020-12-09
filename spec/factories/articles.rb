FactoryBot.define do 
  factory :article do
    content { Faker::Lorem.sentence(word_count: 10)}
  end
end