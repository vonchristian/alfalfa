module Employees
  class OtherDeductionsController < ApplicationController
    layout "accounting"
    def new
      @employee = Employee.find(params[:employee_id])
      @item = @employee.other_deductions.build
    end

    def create
      @employee = Employee.find(params[:employee_id])
      @item = @employee.other_deductions.create(item_params)
      if @item.save
        @item.unpaid!
        redirect_to @employee, notice: "Item saved successfully."
      else
        render :new
      end
    end

    def edit
      @employee = Employee.find(params[:employee_id])
      @item = Item.find(params[:id])
    end

    def update
      @employee = Employee.find(params[:employee_id])
      @item = Item.find(params[:id])
      @item.update(item_params)
      if @item.save
        @item.unpaid!
        redirect_to @employee, notice: "Item updated successfully."
      else
        render :edit
      end
    end

    private
    def item_params
      params.require(:item).permit(:date, :quantity, :description, :unit, :unit_cost, :total_cost)
    end
  end
end
