FactoryGirl.define do
  factory :amount_revision, class: ChangeOrders::AmountRevision do
  amount   {Faker::Number.number(6)}
  remarks "Due to change order no.1"
    project
    end
end
