class EmployeeDetails::EducationalAttainment < ActiveRecord::Base
  belongs_to :employee

  validates :degree, presence: true
end
