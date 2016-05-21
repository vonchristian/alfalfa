FactoryGirl.define do
  factory :inventory, class: "Supplies::Inventory" do
    name "Cement"
    unit "bags"
    price 99.99
  end
end
