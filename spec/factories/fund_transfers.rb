FactoryGirl.define do
  factory :fund_transfer do
    source_account_id 1
    recipient_account_id 1
    amount '1000'
    date Time.zone.now
  end
end
