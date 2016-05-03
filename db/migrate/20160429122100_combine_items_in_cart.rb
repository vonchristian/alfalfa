class CombineItemsInCart < ActiveRecord::Migration
  def up
  # replace multiple items for a single inventory in a cart with a single item
    Supplies::Cart.all.each do |cart|
      # count the number of each inventory in the cart
      sums = cart.line_items.group(:inventory_id).sum(:quantity)
      sums.each do |inventory_id, quantity|
        if quantity > 1
          # remove individual items
          cart.line_items.where(inventory_id: inventory_id).delete_all
          # replace with a single item
          cart.line_items.create(inventory_id: inventory_id, quantity: quantity)
        end
      end
    end
  end

  def down
    # split items with quantity>1 into multiple items
    Supplies::LineItem.where("quantity>1").each do |line_item|
      # add individual items
      line_item.quantity.times do
        Supplies::LineItem.create cart_id: line_item.cart_id,
        inventory_id: line_item.inventory_id, quantity: 1
      end
      # remove original item
      line_item.destroy
    end
  end
end
