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
      authorize @contractor
      if @contractor.save
        redirect_to monitoring_contractors_path, notice: "Contractor saved successfully."
      else
        render :new
      end
    end

    def show
      @contractor = Contractor.find(params[:id])
    end

    def edit
      @contractors = Contractor.all
      @contractor = Contractor.find(params[:id])
    end

    def update
      @contractor = Contractor.find(params[:id])
      authorize @contractor
      if @contractor.update(contractor_params)
        redirect_to monitoring_contractor_path(@contractor), notice: "Contractor updated successfully."
      else
        render :edit
      end
    end

    private
    def contractor_params
      params.require(:contractor).permit(:profile_photo, :first_name, :last_name, :company, :main_contractor, :position)
    end
  end
end
