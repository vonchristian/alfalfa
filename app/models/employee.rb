class Employee < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:first_name, :last_name]

  attachment :photo

  enum position:[:laborer, :skilled_laborer, :foreman, :operator, :welder, :project_engineer]

  has_many :logged_hours
  has_many :payrolls
  has_many :cash_advances, as: :cash_advanceable

def full_name
    "#{first_name} #{last_name}"
  end

  def name
  	full_name
  end
  def rate
    return 400 if self.laborer?
    return 500 if self.skilled_laborer?
    return 500 if foreman?
    return 1000 if project_engineer?
  end
end
