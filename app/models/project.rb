class Project < ActiveRecord::Base

    include PublicActivity::Common
   has_many :collections
    has_one :notice_to_proceed
    belongs_to :main_contractor, class_name: "Contractor", foreign_key: 'main_contractor_id'
    belongs_to :category

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
  

    before_save :add_main_contractor_to_contractors
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
    amount_revisions.sum(:revised_contract_amount)
  end

  def self.total_amount_revisions
    self.joins(:amount_revisions).sum(:revised_contract_amount)
   end

  def self.total_cost_of_projects_with_revisions
    self.total_amount_revisions + self.sum(:cost)
  end
  def slippage
    if notice_to_proceed.present? && accomplishments.present?
      (percent_of_accomplishment - percent_actual_accomplished).round(2)
    else
        0
    end
  end
  def road?
    true
  end

    def percent_of_accomplishment
      if self.accomplishments.present?
        self.accomplishments.sum(:percent)
      else
        0
      end
    end
    def self.with_amount_revisions
where('no_amount_revisions? < ?', false)
end

    def percent_actual_accomplished
       (days_elapsed / duration.to_f) * 100
end


    def no_amount_revisions?
        amount_revisions.empty?
    end

    def revised_contract_amount
        if no_amount_revisions?
           cost
        else
        cost + amount_revisions.sum(:revised_contract_amount)
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
    else
      "NTP Not Yet Awarded"
    end
    end

    def total_number_of_days_extended
        self.time_extensions.sum(:number_of_days)
    end
    
    def days_elapsed
      ((Time.zone.now.to_i - start_date.to_i)/86400).floor
    end

    def remaining_days_before_expiry
      Time.zone.now..(self.expiry_date)
    end
  

    def expiry_date
        if notice_to_proceed.present?
        ((self.notice_to_proceed.date.to_date) + (self.duration))
    else
        "NTP not yet awarded"
    end
    end

    def revised_expiry_date
     if notice_to_proceed.present? && time_extensions.present?
        ((self.notice_to_proceed.date) + (self.duration) + ((total_number_of_days_extended)).days).strftime("%B %d, %Y") 
    else
        "No Time Revisions "
    end
    end

    private
    def add_main_contractor_to_contractors
      Contract.create(contractor_id: self.main_contractor.id, project_id: self.id )
    end

end
