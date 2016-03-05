FactoryGirl.define do
  factory :work_detail do
    code { Faker::Code.isbn }
    description { Faker::Commerce.product_name }
    quantity {Faker::Number.decimal(2)}
    unit 'cu.m'
    unit_cost {Faker::Number.decimal(2)}
    total_cost '122'
    accomplished false
    project nil
  end
end

