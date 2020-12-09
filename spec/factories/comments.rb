FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence(word_count: 5)}
  end
end
