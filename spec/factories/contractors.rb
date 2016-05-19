FactoryGirl.define do
  factory :contractor do
    first_name  { Faker::Name.first_name}
    last_name  { Faker::Name.first_name }
    company  { Faker::Name.first_name}
    trait :main_contractor do
      main_contractor true
    end
  end
end
