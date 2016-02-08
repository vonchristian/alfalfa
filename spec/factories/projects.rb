FactoryGirl.define do
  factory :project do
    name "Road Widening and Additional Concreting"
    # main_contractor
    id_number "16UGS2344"
    address "Kiangan, Ifugao"
    duration "120"
    cost   {Faker::Number.number(6)}
  end
end
