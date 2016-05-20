require 'rails_helper'

RSpec.describe Contract, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :project }
    it { is_expected.to belong_to :contractor }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :contractor_id }
    it { is_expected.to validate_presence_of :amount_subcontracted }
    # it do
    #   is_expected.to validate_uniqueness_of(:contractor_id).scoped_to(:project)
    # end

    it do
      is_expected.to validate_numericality_of(:amount_subcontracted)
    end
  end

  describe "delegations" do
    it { is_expected.to delegate_method(:remaining_uncontracted_amount).to(:project) }
  end
end
