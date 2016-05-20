require 'rails_helper'

RSpec.describe Contractor, type: :model do
  describe "associations" do
    it { is_expected.to have_many :contracts }
    it { is_expected.to have_many :projects }
    it { is_expected.to have_many :orders }
    it { is_expected.to have_many :line_items }
  end
  describe "validations" do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :company }
    it { is_expected.to validate_presence_of :position }
  end
end
