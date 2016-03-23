class PurchaseOrdersController < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @work_detail.purchase_orders.build
  end
end
