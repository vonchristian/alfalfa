class Inventories::SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.create(sale_params)
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
