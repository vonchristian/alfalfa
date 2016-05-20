class AddUserIdToAmountRevisions < ActiveRecord::Migration
  def change
    add_column :amount_revisions, :user_id, :integer
    add_index :amount_revisions, :user_id
  end
end
