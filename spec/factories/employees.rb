FactoryGirl.define do
  factory :employee do
    first_name "MyString"
    last_name "MyString"
    mobile_number "MyString"
    email "MyString"
    photo_id "MyString"
    position "project_foreman"

    factory :employee_with_cash_advances do
    after(:create) do |employee|
       employee.cash_advances << create(:employee_cash_advance, cash_advanceable: employee, amount: 100 )
    end
  end
  end
end
