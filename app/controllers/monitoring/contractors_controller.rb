module Monitoring
  class ContractorsController < ApplicationController
    layout "monitoring"

    def index
      if params[:query].present?
        @contractors = Contractor.search_by_name(params[:query])
      else
        @contractors = Contractor.all
      end
      authorize User
    end

    def show
      @contractor = Contractor.find(params[:id])
    end
    def edit
      @contractor = Contractor.find(params[:id])
    end

    def update
      @contractor = Contractor.find(params[:id])
      @contractor.update(contractor_params)
      if @contractor.save
        redirect_to monitoring_contractor_url(@contractor), notice: "Contractor updated successfully."
      else
        render :edit
      end
    end
  end
end
