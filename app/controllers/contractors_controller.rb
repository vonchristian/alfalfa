class ContractorsController < ApplicationController
  def index
    @contractors = Contractor.all
  end
  def new
    @contractor = Contractor.new
  end

  def create
    @contractor = Contractor.create(contractor_params)
    if @contractor.save
      redirect_to @contractor, notice: "Contractor added successfully."
    else
      render :new
    end
  end

  def show
    @contractor = Contractor.find(params[:id])
  end

  private
  def contractor_params
    params.require(:contractor).permit(:first_name, :middle_name, :last_name, :company, :position, :profile_image)
  end
end
