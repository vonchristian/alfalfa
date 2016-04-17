class AddDateIssuedToIssuedInvetories < ActiveRecord::Migration
  def change
    add_column :issued_inventories, :date_issued, :datetime
  end
end
