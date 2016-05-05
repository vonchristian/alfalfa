class RemoveRecipientIdFromEntries < ActiveRecord::Migration
  def change
    remove_column :entries, :recipient_id, :integer
  end
end
