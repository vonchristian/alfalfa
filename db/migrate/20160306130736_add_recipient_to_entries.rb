class AddRecipientToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :recipient_id, :integer, index: true
  end
end
