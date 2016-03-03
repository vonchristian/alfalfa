require 'rails_helper'

RSpec.describe CashAdvance, type: :model do
  describe "associations" do
    it {is_expected.to belong_to :cash_advanceable }
  end
  describe "validations" do
    it {is_expected.to validate_presence_of :date_disbursed }
    it { is_expected.to validate_numericality_of :amount }
  end
end
