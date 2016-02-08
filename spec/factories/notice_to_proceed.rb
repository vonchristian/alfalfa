FactoryGirl.define do
  factory :notice_to_proceed do
    date Time.zone.now
    project
    end
end
