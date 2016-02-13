class AddContractorIdToProjectBillings < ActiveRecord::Migration
  def change
    add_reference :project_billings, :contractor, index: true, foreign_key: true
  end
end
