module Supplies
  class PaymentsController < ApplicationController
    layout 'supplies'
    def new
      @line_item = Supplies::LineItem.find(params[:line_item_id])
    end
  end
end
