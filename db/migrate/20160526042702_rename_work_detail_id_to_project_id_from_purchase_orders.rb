class RenameWorkDetailIdToProjectIdFromPurchaseOrders < ActiveRecord::Migration
    def change
      rename_column :purchase_orders, :work_detail_id, :project_id
    end
end
