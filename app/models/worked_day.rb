class WorkedDay < ActiveRecord::Base

  belongs_to :employee
  belongs_to :project
  has_many :payments, as: :paymentable

  validates :number_of_days, presence: true, numericality: { less_than: 30 }

  enum status:[:paid, :unpaid]

  def set_to_unpaid!
    self.unpaid!
  end
end
