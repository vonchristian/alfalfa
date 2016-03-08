FactoryGirl.define do
  factory :cash_advance do
    cash_advanceable nil
    amount "9.99"
    date_disbursed Time.zone.now
  end
end
