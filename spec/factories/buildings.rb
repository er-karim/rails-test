FactoryBot.define do
  factory :building do
    reference { 1 }
    address { "MyString" }
    zip_code { "MyString" }
    city { "MyString" }
    country { "MyString" }
    manager_name { "MyString" }
  end
end
