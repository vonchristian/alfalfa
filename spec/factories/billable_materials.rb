FactoryGirl.define do
  factory :billable_material do
    contractor nil
    inventory nil
    cost "9.99"
    reference_number 1
    quantity 1
    project nil
  end
end
