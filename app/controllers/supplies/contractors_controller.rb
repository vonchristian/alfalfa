module Supplies
  class ContractorsController < ApplicationController
    layout 'supplies'
    def show
      @contractor = Contractor.find(params[:id])
    end
  end
end
