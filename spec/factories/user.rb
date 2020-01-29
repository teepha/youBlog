FactoryBot.define do
  factory :user, aliases: [:userx] do
    username { Faker::Name.first_name}
    email { Faker::Internet.email }
    password { Faker::Lorem.word }
    biography { Faker::Lorem.sentence(8) }

    factory :admin do
      admin { true }
    end
  end
end
