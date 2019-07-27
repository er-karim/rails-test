FactoryBot.define do
  factory :person do
    reference { 1 }
    email { "mystring@test.dev" }
    home_phone_number { "0511111111" }
    mobile_phone_number { "0622222222" }
    firstname { "firstname" }
    lastname { "lastname" }
    address { "address" }

    trait :random_person do
      reference { rand(2..10000) }
      email { Faker::Internet.email }
      home_phone_number { Faker::PhoneNumber.cell_phone }
      mobile_phone_number { Faker::PhoneNumber.phone_number }
      firstname { Faker::Name.first_name }
      lastname { Faker::Name.last_name }
      address { Faker::Address.street_address }
    end
  end
end
