FactoryGirl.define do
  factory :worked_day do
    number_of_days 10
    start_date    {Faker::Date.backward(10)}
    end_date      {Faker::Date.forward(10)}
    employee nil
  end
end
