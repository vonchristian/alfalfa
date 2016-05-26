module Monitoring
  class PurchaseOrdersController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
      @purchase_orders = @project.purchase_orders
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PurchaseOrdersPdf.new(@project, @purchase_orders, view_context)
          			send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Purchase Orders.pdf"
        end
      end
    end
    def new
      @project = Project.find(params[:project_id])
      @purchase_order = @project.purchase_orders.build
    end
    def create
      @project = Project.find(params[:project_id])
      @purchase_order = @project.purchase_orders.create(purchase_order_params)
      if @purchase_order.save
        redirect_to monitoring_project_url(@project), notice: "Order saved successfully."
      else
        render :new
      end
    end

    private
    def purchase_order_params
      params.require(:monitoring_purchase_order).permit(:quantity, :unit, :description, :unit_cost, :amount, :date)
    end
  end
end
