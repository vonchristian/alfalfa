class WorkedDay < ActiveRecord::Base

  belongs_to :employee

  validates :number_of_days, presence: true, numericality: { less_than: 30 }
  validates :start_date, :end_date, presence: true
  validates_datetime :end_date, :after => :start_date
  enum status:[:paid, :unpaid]

  

  def self.set_to_paid!
    self.all.unpaid.each do |a|
      a.paid!
      a.save
    end
  end

  def self.total
    all.sum(:number_of_days)
  end
end
