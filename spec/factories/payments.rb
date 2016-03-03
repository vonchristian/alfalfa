FactoryGirl.define do
  factory :payment do
    amount "9.99"
    paymentable_id 1
    paymentable_type "MyString"
    payment_type 1
    date "2016-03-02 09:16:32"
  end
end
