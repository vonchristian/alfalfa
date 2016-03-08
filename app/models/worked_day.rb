class WorkedDay < ActiveRecord::Base

  belongs_to :employee
  belongs_to :project
  has_many :payments, as: :paymentable

  validates :number_of_days, presence: true, numericality: { less_than: 30 }
  validates :start_date, :end_date, presence: true
  enum status:[:paid, :unpaid]

  def set_to_unpaid!
    self.unpaid!
  end

  def self.set_to_paid!
    self.all.unpaid.each do |a|
      a.paid!
      a.save
    end
  end

  def self.total
    self.all.sum(:number_of_days)
  end
end
