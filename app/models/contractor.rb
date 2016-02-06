class Contractor < ActiveRecord::Base
  attachment :profile_image, type: :image
  belongs_to :bid
  has_many :contracts
  has_many :billings
  has_many :projects, through: :contracts
  def self.main_contractors
    self.where(:main_contractor => true)
  end


  def self.sub_contractors
    self.where(:main_contractor => false)
  end
  def full_name
    "#{first_name} #{middle_name.first.upcase}. #{last_name}"
  end
  def to_s
    "#{company}"
  end
end
