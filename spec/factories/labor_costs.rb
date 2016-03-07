FactoryGirl.define do
  factory :labor_cost, class: "WorkDetailCosts::LaborCost" do
    personnel "MyString"
    number_of_personnel "MyString"
    number_of_days "MyString"
    daily_rate "MyString"
    work_detail nil
  end
end
