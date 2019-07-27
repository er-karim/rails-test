FactoryBot.define do
  factory :building do
    reference { 1 }
    address { "adress" }
    zip_code { "111111" }
    city { "city" }
    country { "country" }
    manager_name { "manager name" }

    trait :random_building do
      reference { rand(2..10000) }
      address { Faker::Address.street_address }
      zip_code { Faker::Address.zip_code }
      city { Faker::Address.city }
      country { Faker::Address.country }
      manager_name { Faker::Name.name }
    end
  end
end
