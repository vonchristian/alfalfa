class Project < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch
  multisearchable :against => [:name],
   :order_within_rank => "projects.created_at DESC"
   has_many :collections
   has_many :project_billings
    has_one :notice_to_proceed
    belongs_to :main_contractor, class_name: "Contractor", foreign_key: 'main_contractor_id'
    belongs_to :category
    has_many :workers
    has_many :employees, through: :workers

    has_many :expenses, class_name: "Plutus::Entry", foreign_key: "commercial_document_id"
    has_many :activities, class_name: "PublicActivity::Activity", foreign_key: "trackable_id"
    has_many :bids
    has_many :billings
    has_many :contracts
    has_many :contractors, through: :contracts
    has_many :time_extensions
    has_many :amount_revisions
    has_many :accomplishments
    has_many :remarks

  
    validates :name,  :id_number, :duration, :cost, :address, presence: true
  validates :id_number, uniqueness: true

    after_create :add_main_contractor_to_contractors
    after_commit :add_to_accounts
    
   def total_collection
    self.collections.sum(:amount)
  end
  def remaining_collection
    revised_contract_amount -  total_collection
  end
  def total_expenses
    expenses.joins(:debit_amounts).sum(:amount)
  end

  def total_amount_revision
    amount_revisions.sum(:amount)
  end

  def self.total_amount_revisions
    self.joins(:amount_revisions).sum(:amount)
   end

  def self.total_cost_of_projects_with_revisions
    self.total_amount_revisions + self.sum(:cost)
  end
  def slippage
    if notice_to_proceed.present?
      (actual_accomplishment - target_accomplishment ).round(2)
    else
        0
    end
  end
  def latest_duration
    if time_extensions.present?
      time_extensions.sum(:number_of_days) + duration 
    else
      duration
    end
  end

    def actual_accomplishment
      if self.accomplishments.present?
        self.accomplishments.sum(:percent)
      else
        0
      end
    end

    def target_accomplishment
      if notice_to_proceed.present?
       ((days_elapsed / duration.to_f) * 100).round(2)
     else
      0
     end
end


    def no_amount_revisions?
        amount_revisions.empty?
    end

    def revised_contract_amount
        if no_amount_revisions?
           cost
        else
        cost + amount_revisions.sum(:amount)
    end
    end
    def final_expiry_date
    if  time_extensions.present?
       revised_expiry_date
    else
      expiry_date 
    end
  end

    def start_date
      if notice_to_proceed
      notice_to_proceed.date
    end
    end

    def total_number_of_days_extended
        self.time_extensions.sum(:number_of_days)
    end
    
    def days_elapsed
      if notice_to_proceed
      ((Time.zone.now.to_i - start_date.to_i)/86400).floor
    else
      0
    end
    end

    def remaining_days
      revised_duration - days_elapsed
    end
  

    def expiry_date
        if notice_to_proceed.present?
        ((self.notice_to_proceed.date.to_date) + (self.duration))
    end
    end

    def revised_expiry_date
     if notice_to_proceed.present? && time_extensions.present?
        self.notice_to_proceed.date + self.revised_duration.days
      end
    end

    def revised_duration
      self.duration + self.total_number_of_days_extended
    end
    private
    def add_main_contractor_to_contractors
      Contract.create(contractor_id: self.main_contractor.id, project_id: self.id ) if self.new_record?
    end

     def add_to_accounts
       Plutus::Entry.create!(description: self.name, debit_amounts_attributes:[amount: (self.cost), account: "Trade Payable"],
                         credit_amounts_attributes:[amount: (self.cost), account: "Receivables"])
   end

end
