FactoryGirl.define do
  factory :contractor do
    name "Road Widening and Additional Concreting"
    main_contractor
    trait :main_contractor do 
      main_contractor true
    end
  end
end
