FactoryGirl.define do
  factory :employee_cash_advance, class: "CashAdvance" do
    association :cash_advanceable, factory: :employee
    amount "9.99"
    date_disbursed Time.zone.now
    status 'unpaid'
  end
end
