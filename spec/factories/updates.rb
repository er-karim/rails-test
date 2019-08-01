FactoryBot.define do
  factory :update do
    field { "field" }
    value { "value" }
    updatable { [build(:person), build(:building)].sample }

    trait :with_person do
      field { "email" }
      value { "mystring@test.dev" }
      updatable { build(:person) }
    end    
    trait :with_person do
      field { "manager_name" }
      value { "manager name" }
      updatable { build(:building) }
    end
  end
end
