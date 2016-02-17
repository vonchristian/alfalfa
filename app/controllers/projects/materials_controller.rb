class Projects::MaterialsController  < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @material = @work_detail.materials.build
  end
  def create
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @material = @work_detail.materials.create(material_params)
    if @material.save
      redirect_to project_work_detail_path(@work_detail.project, @work_detail), notice: "Material added successfully"
    else
      render :new
  end
end

private
def material_params
  params.require(:material).permit(:unit, :unit_cost, :quantity, :description, :total_cost)
end
end
