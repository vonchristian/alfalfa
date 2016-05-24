FactoryGirl.define do
  factory :overtime_pay, class: "Accounting::Employees::OvertimePay" do
    employee nil
    number_of_hours "9.99"
    status 0
  end
end
