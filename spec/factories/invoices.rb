FactoryGirl.define do
  factory :invoice do
    amount "9.99"
    invoiceable_id 1
    invoiceable_type "MyString"
    date "2016-03-25 18:37:33"
  end
end
