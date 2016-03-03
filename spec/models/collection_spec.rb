require 'rails_helper'

RSpec.describe Collection, type: :model do
   describe "associations" do
    it {is_expected.to belong_to :project }
  end
end
