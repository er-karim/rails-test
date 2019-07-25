FactoryBot.define do
  factory :person do
    reference { 1 }
    email { "mystring@test.dev" }
    home_phone_number { "MyString" }
    mobile_phone_number { "MyString" }
    firstname { "MyString" }
    lastname { "MyString" }
    address { "MyString" }
  end
end
