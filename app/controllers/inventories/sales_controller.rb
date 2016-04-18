class Inventories::SalesController < ApplicationController

  def index
    @sales = Sale.all
    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
    respond_to do |format|
      format.html
      format.pdf do
         pdf = SalesPdf.new(@sales, @from_date, @to_date, view_context)
      send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Sales.pdf"
      end
    end
  end

  def new
    @sales = Sale.all
    @sale = Sale.new
    authorize @sale
  end

  def create
    @sale = Sale.create(sale_params)
    authorize @sale
    if @sale.save
      @sale.update_accounts
      redirect_to new_sale_path, notice: "Sale recorded successfully."
    else
      render :new
    end
  end

  private
  def sale_params
    params.require(:sale).permit(:recipient, :inventory_id, :quantity, :amount, :date)
  end
end
