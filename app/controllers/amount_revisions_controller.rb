class AmountRevisionsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @amount_revision = @project.amount_revisions.build
    authorize @amount_revision
  end

  def create
    @project = Project.find(params[:project_id])
    @amount_revision = @project.amount_revisions.create(amount_revision_params)
    authorize @amount_revision
    if @amount_revision.save
      redirect_to @project, notice: "Successfully added."
    else
      render :new
    end
  end

  private
  def amount_revision_params
    params.require(:change_orders_amount_revision).permit(:amount, :remarks)
  end
end
