class AddDateToAmountRevisions < ActiveRecord::Migration
  def change
    add_column :amount_revisions, :date, :datetime
  end
end
