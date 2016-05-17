require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "validations" do
    it {is_expected.to validate_presence_of :first_name }
    it {is_expected.to validate_presence_of :last_name }
    it {is_expected.to validate_presence_of :mobile_number }
    it {is_expected.to validate_presence_of :email }
    it {is_expected.to validate_presence_of :position }


  end
   describe "associations" do
    it {is_expected.to have_many :educational_attainments }
    it {is_expected.to have_many :worked_days }
    it {is_expected.to have_many :employments }
    it {is_expected.to have_many :projects }
    it {is_expected.to have_many :work_details }
    it {is_expected.to have_many :equipment_schedules }
    it {is_expected.to have_many :equipments }
  end

  it ".full_name" do
    employee = build(:employee, first_name: 'Von', last_name: "Halip")

    expect(employee.full_name).to eql("Von Halip")
  end
  it ".name" do
     employee = build(:employee, first_name: 'Von', last_name: "Halip")

    expect(employee.name).to eql(employee.full_name)
  end

  it ".unpaid_worked_days_amount" do
    employee = create(:employee, rate: 500)
    worked_day = create(:worked_day, employee: employee, number_of_days: 10, status: 'unpaid')

    expect(employee.unpaid_worked_days_amount).to eql(5_000.0)
  end

  describe "photo attachment" do
    it { should have_attached_file(:profile_photo) }
    it { should validate_attachment_presence(:profile_photo) }
    it { should validate_attachment_content_type(:profile_photo).
               allowing('image/png', 'image/gif').
               rejecting('text/plain', 'text/xml') }
  end

  describe "enum for position" do
    it do
      should define_enum_for(:position).with([ :laborer,
                                               :skilled_laborer,
                                               :project_foreman,
                                               :operator,
                                               :welder,
                                               :project_engineer,
                                               :bookkeeper,
                                               :liason_officer,
                                               :supply_officer,
                                               :accounting_officer,
                                               :monitoring_officer,
                                               :mechanical_engineer])
    end
  end
end
