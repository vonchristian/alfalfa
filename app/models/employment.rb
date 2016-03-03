class Employment < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  validates :employee_id, uniqueness: {scope: :project, message: "Already added"}
end
