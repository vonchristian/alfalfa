require 'rails_helper'

RSpec.describe Supplies::Inventory, type: :model do
  describe "associations" do
    it { is_expected.to have_many :stocks }
    it { is_expected.to have_many :line_items }
    it { is_expected.to have_many :orders }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :unit }
    it { is_expected.to validate_presence_of :price }
    it do
      is_expected.to validate_numericality_of(:price).is_greater_than(0.1)
    end
  end

  describe "nested_attributes" do
    it { is_expected.to accept_nested_attributes_for(:stocks)}
  end
end
