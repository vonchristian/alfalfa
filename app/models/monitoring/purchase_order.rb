module Monitoring
  class PurchaseOrder < ActiveRecord::Base
    belongs_to :project

    def total_price
        unit_cost * quantity
      end

      def self.total_price
          self.all.to_a.sum { |item| item.amount }
      end
  end
end
