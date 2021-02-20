FactoryBot.define do
  factory :category, aliases: [:categoryx] do
    name { Faker::Lorem.word}
  end
end
