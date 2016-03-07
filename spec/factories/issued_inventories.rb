FactoryGirl.define do
  factory :issued_inventory do
    code "122"
    description "Product"
    unit "m"
    quantity "10"
    unit_cost "1"
    total_cost "10"
    inventory nil
  end
end
