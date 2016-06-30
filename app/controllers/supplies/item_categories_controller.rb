module Supplies
  class ItemCategoriesController < ApplicationController
    layout "accounting"
    def new
      @item_category = ItemCategory.new
    end

    def create
      @item_category = ItemCategory.create(item_category_params)
    end
    private
    def item_category_params
      params.require(:item_category).permit(:name)
    end
  end
end
