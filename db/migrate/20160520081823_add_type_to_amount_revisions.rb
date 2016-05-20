class AddTypeToAmountRevisions < ActiveRecord::Migration
  def change
    add_column :amount_revisions, :type, :string
  end
end
