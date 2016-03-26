class Inventories::SalesController < ApplicationController
  def new
    @sales = Sale.all
    @sale = Sale.new
    authorize @sale
  end

  def create
    @sale = Sale.create(sale_params)
    authorize @sale
    if @sale.save
      redirect_to new_sale_path, notice: "Sale recorded successfully."
    else
      render :new
    end
  end

  private
  def sale_params
    params.require(:sale).permit(:inventory_id, :quantity, :amount, :date)
  end
end
