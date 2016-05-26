class RemoveTypeFromAmountRevisions < ActiveRecord::Migration
  def change
    remove_column :amount_revisions, :type, :string
    add_column :amount_revisions, :revision_type, :integer

  end
end
