require 'rails_helper'
RSpec.describe Accounting::Employees::Overtime, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :employee }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :number_of_hours }
    it { is_expected.to validate_presence_of :start_date }
    it { is_expected.to validate_presence_of :end_date }
    it do
      is_expected.to validate_numericality_of(:number_of_hours).is_greater_than(0.1)
    end
  end

  describe "enum for status" do
    it do
      is_expected.to define_enum_for(:status).with([:unpaid, :paid])
    end
  end

end
