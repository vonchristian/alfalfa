module Supplies
  class ItemCategoriesController < ApplicationController
    layout "accounting"
    def new
      @item_category = ItemCategory.new
    end

    def create
      @item_category = ItemCategory.new(item_category_params)
    end
    private
    def item_category_params
      params.require(:accounting_item_category).permit(:description, :item_category_type,  :date, :reference_number, :entriable_id, :entriable_type, :credit_amounts_attributes=> [:id, :amount, :account],:debit_amounts_attributes=> [:id, :amount, :account])
    end
  end
end
