class AddReferenceNumberToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :reference_number, :string
  end
end
