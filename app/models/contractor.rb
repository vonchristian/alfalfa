class Contractor < ActiveRecord::Base
   include PgSearch
  multisearchable :against => [:first_name, :last_name, :company]
  attachment :profile_image, type: :image
  belongs_to :bid
  has_many :contracts
  has_many :billings
  has_many :projects, through: :contracts
  has_many :project_billings
 

  def self.main_contractors
    self.where(:main_contractor => true)
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
