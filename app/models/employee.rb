class Employee < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:first_name, :last_name]

  attachment :photo

  enum position:[:laborer, :operator, :wielder]

  has_many :project_workers
  has_many :projects, through: :project_workers
  has_many :cash_advances, as: :cash_advanceable
def full_name
    "#{first_name} #{last_name}"
  end

  def name
  	full_name
  end
end
