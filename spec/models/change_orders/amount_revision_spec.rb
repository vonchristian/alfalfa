require 'rails_helper'

RSpec.describe ChangeOrders::AmountRevision, type: :model do
  describe "validations" do
    it {is_expected.to validate_numericality_of :amount }
    it {is_expected.to validate_presence_of :amount }
    it {is_expected.to validate_presence_of :remarks }
    it {is_expected.to validate_presence_of :date }
  end

  describe "associations" do
    it { is_expected.to belong_to :work_detail }
    it { is_expected.to belong_to :recorder }
  end
end
