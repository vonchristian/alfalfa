module Accounting
  module Employees
    class Overtime < ActiveRecord::Base
      belongs_to :employee
      validates :start_date, :end_date, presence: true
      validates_datetime :end_date, after: :project_created_at, after_message: "Must be after the start date"

      validates :number_of_hours, presence: true, numericality: { greater_than: 0.1 }
      enum status:[:unpaid, :paid]

      def self.set_to_paid!
        self.all.unpaid.each do |a|
          a.paid!
          a.save
        end
      end

      def self.total
        all.sum(:number_of_hours)
      end
    end
  end
end
