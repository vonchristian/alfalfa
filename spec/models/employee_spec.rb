require 'rails_helper'

RSpec.describe Employee, type: :model do
   describe "associations" do
    it {is_expected.to have_many :educational_attainments }
    it {is_expected.to have_many :worked_days }
    it {is_expected.to have_many :payments }
    it {is_expected.to have_many :cash_advances }
    it {is_expected.to have_many :employments }
    it {is_expected.to have_many :projects }
  end

  it ".full_name" do
    employee = build(:employee, first_name: 'Von', last_name: "Halip")

    expect(employee.full_name).to eql("Von Halip")
  end
  it ".name" do
     employee = build(:employee, first_name: 'Von', last_name: "Halip")

    expect(employee.name).to eql(employee.full_name)
  end

  it ".unpaid_worked_days_for(project)" do
    employee = create(:employee)
    project = create(:project)
    worked_day1 = create(:worked_day, number_of_days: 2, project: project, employee: employee, status: 'unpaid')
    worked_day2 = create(:worked_day, number_of_days: 2, project: project, employee: employee, status: 'unpaid')

    expect(employee.unpaid_worked_days_for(project)).to eql(4)
  end
end
