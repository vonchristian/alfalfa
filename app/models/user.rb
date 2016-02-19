class User < ActiveRecord::Base
  attachment :profile_photo
    enum role: [:system_administrator, :accounting_officer, :project_engineer, :supply_officer, :owner]
    has_one :address, as: :addressable
    has_one :additional_information, as: :informeable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :additional_information

  def full_name
    "#{first_name.titleize} #{last_name.titleize}"
  end
end
