class Supplies::Cart < ActiveRecord::Base
  has_many :line_items, class_name: "Supplies::LineItem", dependent: :destroy

def total_price
  line_items.to_a.sum { |item| item.total_price }
end

# def add_inventory(inventory_id)
#   current_item = line_items.find_by_inventory_id(inventory_id)
#   if current_item
#     current_item.quantity += 1
#   else
#     current_item = line_items.build(inventory_id: inventory_id)
#   end
#   current_item
# end

  def add_inventory
    sums = self.line_items.group(:inventory_id).sum(:quantity)
    sums.each do |inventory_id, quantity|
      if quantity > 1
        # remove individual items
        self.line_items.where(inventory_id: inventory_id).delete_all
        # replace with a single item
        self.line_items.create(inventory_id: inventory_id, quantity: quantity)
      end
    end
  end
end
