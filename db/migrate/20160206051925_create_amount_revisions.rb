class CreateAmountRevisions < ActiveRecord::Migration
  def change
    create_table :amount_revisions do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.decimal :revised_contract_amount

      t.timestamps null: false
    end
  end
end
