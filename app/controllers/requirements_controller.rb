class RequirementsController < ApplicationController
  def index
    @requirements = Requirement.all
  end
  
  def new
    @requirement = Requirement.new
  end

  def create
    @requirement = Requirement.create(requirement_params)
    if @requirement.save
      redirect_to @requirement, notice: "Added"
    else
      render :new
    end
  end

  def show
    @requirement = Requirement.find(params[:id])
  end

  private
  def requirement_params
    params.require(:requirement).permit(:name)
  end
end
