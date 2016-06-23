class AddRecipientIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :recipient_id, :integer
    add_index :entries, :recipient_id
    add_column :entries, :recipient_type, :string
    add_index :entries, :recipient_type
  end
end
