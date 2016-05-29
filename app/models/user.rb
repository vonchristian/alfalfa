class User < ActiveRecord::Base

  enum role: [:system_administrator, :accounting_officer, :project_engineer, :project_manager, :supply_officer, :owner, :liason_officer, :monitoring_officer, :mechanical_engineer]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :role, :first_name, :last_name, presence: true
  has_attached_file :profile_photo,
                    styles: { large: "120x120>",
                    medium: "70x70>",
                    thumb: "40x40>",
                    small: "30x30>",
                    x_small: "20x20>"},
                      default_url: ":style/profile_default.jpg",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
  validates_attachment :profile_photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  def full_name
    "#{first_name.titleize} #{last_name.titleize}"
  end
end
