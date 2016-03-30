class User < ActiveRecord::Base
  attachment :profile_photo
    enum role: [:system_administrator, :accounting_officer, :project_engineer, :project_manager, :supply_officer, :owner, :liason_officer, :monitoring_officer, :mechanical_engineer]


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name.titleize} #{last_name.titleize}"
  end
end

