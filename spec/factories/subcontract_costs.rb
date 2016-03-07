FactoryGirl.define do
  factory :subcontract_cost, class: "WorkDetailCosts::Subcontract_cost" do
    amount "MyString"
    contractor nil
    quantity "MyString"
    work_detail nil
    description "MyString"
  end
end
