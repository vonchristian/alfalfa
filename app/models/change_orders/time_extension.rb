class ChangeOrders::TimeExtension < ActiveRecord::Base
  validates :number_of_days, presence: true, numericality: { greater_than: 0.1 }
  validates :remarks, presence: true
  belongs_to :project
  belongs_to :recorder, class_name: "User", foreign_key: 'user_id'
  def self.total
    self.all.sum(:number_of_days)
  end
end
