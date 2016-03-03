FactoryGirl.define do
  factory :notice_to_proceed, class: ProjectDetails::NoticeToProceed do
    date Time.zone.now
    project
    end
end
