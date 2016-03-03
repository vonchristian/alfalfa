require 'rails_helper'

RSpec.describe EmployeeDetails::EducationalAttainment, type: :model do

  describe "associations" do
    it {is_expected.to belong_to :employee }
  end

  describe "validations" do
    it {is_expected.to validate_presence_of :degree }
  end
end
