class Contractor < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:first_name, :last_name, :company]

  has_attached_file :profile_photo, styles: { large: "120x120>", medium: "70x70>", thumb: "40x40>", small: "30x30>", x_small: "20x20>" }, default_url: "/images/:style/missing.png"
  validates_attachment :profile_photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  
  has_many :contracts
  has_many :projects, through: :contracts
  has_many :issued_inventories


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
