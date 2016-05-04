class ContractorsController < ApplicationController
  layout "projects"
  def index
    @contractors = Contractor.all
  end
  def new
    @contractor = Contractor.new
    authorize @contractor
  end

  def create
    @contractor = Contractor.create(contractor_params)
    authorize @contractor
    if @contractor.save
      redirect_to @contractor, notice: "Contractor added successfully."
    else
      render :new
    end
  end

  def show
    @contractor = Contractor.find(params[:id])
    @issued_inventories = @contractor.issued_inventories.all
    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.zone.now.beginning_of_day
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.zone.now.end_of_day
    @project = Project.find(params[:project_id]) if params[:project_id].present?
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ContractorMaterialsPdf.new(@issued_inventories, @contractor, @project, @from_date, @to_date, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
      end
    end
  end

  def edit
    @contractor = Contractor.find(params[:id])
    authorize @contractor
  end

  def update
     @contractor = Contractor.find(params[:id])
      @contractor.update(contractor_params)
      authorize @contractor
    if @contractor.save
      redirect_to @contractor, notice: "Contractor updated successfully."
    else
      render :new
    end
  end

  private
  def contractor_params
    params.require(:contractor).permit(:first_name, :middle_name, :last_name, :company, :position, :profile_photo, :main_contractor)
  end
end
