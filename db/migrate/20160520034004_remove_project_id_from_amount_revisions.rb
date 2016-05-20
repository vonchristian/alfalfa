class RemoveProjectIdFromAmountRevisions < ActiveRecord::Migration
  def up
    remove_column :amount_revisions, :project_id, :integer
  end
  def down
    add_column :amount_revisions, :project_id, :integer, index: true
  end
end
