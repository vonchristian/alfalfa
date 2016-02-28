class Employee < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:first_name, :last_name]

  attachment :photo

  enum position:[:laborer, :skilled_laborer, :foreman, :operator, :welder, :project_engineer]

  has_many :workers
  has_many :projects, through: :workers
  has_many :cash_advances, as: :cash_advanceable
def full_name
    "#{first_name} #{last_name}"
  end

  def name
  	full_name
  end
end
