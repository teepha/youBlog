FactoryBot.define do
  factory :article, aliases: [:article2] do
    title { Faker::Lorem.sentence(3) }
    description { Faker::Lorem.sentence(30) }
  end
end
