class AmountRevisionsController < ApplicationController 
  def new 
    @project = Project.find(params[:project_id])
    @amount_revision = @project.amount_revisions.build
  end

  def create
    @project = Project.find(params[:project_id])
    @amount_revision = @project.amount_revisions.build(amount_revision_params)
      if @amount_revision.save 
      redirect_to @project, notice: "Successfully added."
    else
      render :new 
    end
  end

  private 
  def amount_revision_params
    params.require(:amount_revision).permit(:amount)
  end
end
