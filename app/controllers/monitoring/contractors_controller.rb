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

    def new
      @contractor = Contractor.new
    end

    def create
      @contractors = Contractor.all
      @contractor = Contractor.create(contractor_params)
    end

    def show
      @contractor = Contractor.find(params[:id])
    end

    def edit
      @contractor = Contractor.find(params[:id])
    end

    def update
      @contractors = Contractor.all
      @contractor = Contractor.find(params[:id])
      @contractor.update_attributes(contractor_params)
    end

    private
    def contractor_params
      params.require(:contractor).permit(:profile_photo, :first_name, :last_name, :company, :main_contractor, :position)
    end
  end
end
