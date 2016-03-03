require 'rails_helper'

RSpec.describe WorkDetailCosts::LaborCost, type: :model do
   describe "associations" do
    it {is_expected.to belong_to :work_detail }
  end
end
