FactoryGirl.define do
  factory :project do
    name "Road Widening and Additional Concreting"
    association :main_contractor, factory: :contractor
    id_number "16UGS2344"
    address "Kiangan, Ifugao"
    duration "120"
    implementing_office "DPWH"
    created_at Time.zone.now.yesterday
    cost   {Faker::Number.number(6)}
  end
end
