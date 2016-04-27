require 'rails_helper'

RSpec.describe ChangeOrders::TimeExtension, type: :model do
  describe "validations" do
    it {is_expected.to validate_numericality_of :number_of_days }
    it {is_expected.to validate_presence_of :number_of_days }
    it {is_expected.to validate_presence_of :remarks }
  end

  describe "associations" do
    it { is_expected.to belong_to :work_detail }
  end
end
