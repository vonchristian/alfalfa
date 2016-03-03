class Contractor < ActiveRecord::Base
   include PgSearch
  multisearchable :against => [:first_name, :last_name, :company]
  attachment :profile_image, type: :image
  has_many :contracts
  has_many :projects, through: :contracts
  has_many :issued_materials


  def self.main_contractors
    self.where(:main_contractor => true)
  end

  def subcontracted_amount(project)
    project.contracts.sum(:amount_subcontrated)
end

  def self.sub_contractors
    self.where(:main_contractor => false)
  end
  def full_name
    "#{first_name} #{last_name}"
  end
  def to_s
    "#{company}"
  end

  def name
    full_name
  end

end
