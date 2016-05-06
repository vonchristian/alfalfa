class Projects::IssuedInventoriesController < ApplicationController
  def index
    @project = Project.find(:id)
    respond_to do |format|
      format.pdf do
        pdf = IssuedInventorytoProjectPdf.new(@project, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
      end
    end
  end
end

  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
  end

  def create
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @issued_inventory = @work_detail.issued_inventories.create(issued_inventory_params)
    if @issued_inventory.save
      redirect_to project_work_detail_path(@work_detail.project, @work_detail), notice: "Material Expense added successfully."
    else
      render :new
    end
  end

  private
  def issued_inventory_params
    params.require(:issued_inventory).permit(:date_issued, :contractor_id, :quantity, :unit_cost, :total_cost, :inventory_id)
  end

end
