require 'rails_helper'

RSpec.describe Supplies::Order, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :date_issued }
  end
end
