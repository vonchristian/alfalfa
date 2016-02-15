class Employee < ActiveRecord::Base
	attachment :photo
	enum position:[:laborer, :operator, :wielder]
	has_many :project_workers
	has_many :projects, through: :project_workers
def full_name
    "#{first_name} #{last_name}"
  end
end
