class Contractor < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:first_name, :last_name, :company]
  pg_search_scope :search_by_name, :against => [:first_name, :last_name]
  has_attached_file :profile_photo, styles: { large: "120x120>", medium: "70x70>", thumb: "40x40>", small: "30x30>", x_small: "20x20>" }, default_url: ":style/profile_default.jpg"
  validates_attachment :profile_photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  has_many :contracts
  has_many :projects, through: :contracts
  has_many :orders, as: :customer, foreign_key: "customer_id", class_name: "Supplies::Order"
  has_many :line_items, through: :orders, class_name: "Supplies::LineItem"
  validates :first_name, :last_name, :company, :position, presence: true
  def self.entered_on(hash={})
    if hash[:from_date] && hash[:to_date] && params[:project_id]
      from_date = hash[:from_date].kind_of?(Time) ? hash[:from_date] : Time.parse(hash[:from_date].strftime('%Y-%m-%d 12:00:00'))
      to_date = hash[:to_date].kind_of?(Time) ? hash[:to_date] : Time.parse(hash[:to_date].strftime('%Y-%m-%d 12:59:59'))
      project_id = params[:inventoriable_id]
      self.issued_inventories.where('date_issued' => from_date..to_date).where('project_id' => project_id)
    else
      self.issued_inventories.all
    end
  end

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
