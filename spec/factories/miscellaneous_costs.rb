FactoryGirl.define do
  factory :miscellaneous_cost, class: "WorkDetailCosts::MiscellaneousCost" do
    description "MyString"
    amount "MyString"
    work_detail nil
  end
end
