FactoryGirl.define do
  factory :employee do
    first_name "Von Christian"
    last_name "Halip"
    mobile_number "09274173271"
    email "vc.halip@gmail.com"
    profile_photo { File.new("#{Rails.root}/spec/support/fixtures/images.png") }
    position "project_foreman"
    rate 500
  end
end
