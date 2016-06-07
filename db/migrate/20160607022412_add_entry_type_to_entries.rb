class AddEntryTypeToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :entry_type, :integer
    add_index :entries, :entry_type
  end
end
