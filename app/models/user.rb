class User < ActiveRecord::Base
  attachment :profile_photo
    enum role: [:system_administrator, :accounting_officer, :project_engineer, :supply_officer]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def full_name
    "#{first_name.titleize} #{last_name.titleize}"
  end
end
