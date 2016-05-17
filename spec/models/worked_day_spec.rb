require 'rails_helper'

RSpec.describe WorkedDay, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :employee }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :number_of_days }
    it do
       is_expected.to validate_numericality_of(:number_of_days).is_less_than(30)
    end
    it { is_expected.to validate_presence_of :start_date }
    it { is_expected.to validate_presence_of :end_date }
  end
  describe "enum for status" do
    it do
      is_expected.to define_enum_for(:status).with([:paid, :unpaid])
    end
  end

  it "#total" do
    worked_day1 = create(:worked_day, number_of_days: 10)
    worked_day2 = create(:worked_day, number_of_days: 10)

    expect(WorkedDay.total).to eql(20.0)
  end
  it "#set_to_paid!" do
    worked_day1 = create(:worked_day, number_of_days: 10, status: 'unpaid')
    worked_day2 = create(:worked_day, number_of_days: 10, status: 'unpaid')
    expect(worked_day1.status).to eql('unpaid')
    expect(worked_day2.status).to eql('unpaid')

    WorkedDay.set_to_paid!

    expect(worked_day1.status).to eq('paid')
    expect(worked_day2.status).to eq('paid')
  end



end
