require 'rails_helper'

RSpec.describe ChangeOrders::AmountRevision, type: :model do
  describe "validations" do
    it {is_expected.to validate_numericality_of :amount }
    it {is_expected.to validate_presence_of :amount }
    it {is_expected.to validate_presence_of :remarks }
  end

  describe "associations" do
    it { is_expected.to belong_to :project }
  end
end
