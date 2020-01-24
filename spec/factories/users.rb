FactoryBot.define do
  factory :user, aliases: [:userx] do
    username { Faker::Name.first_name}
    email { Faker::Internet.email }
    password { Faker::Lorem.word }
    biography { Faker::Lorem.sentence(10) }

    factory :admin do
      is_admin { true }
    end
  end
end
