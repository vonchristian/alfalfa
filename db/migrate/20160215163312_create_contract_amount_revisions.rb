class CreateContractAmountRevisions < ActiveRecord::Migration
  def change
    create_table :contract_amount_revisions do |t|
      t.belongs_to :contract, index: true, foreign_key: true
      t.belongs_to :contractor, index: true, foreign_key: true
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
