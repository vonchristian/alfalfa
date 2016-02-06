class AmountRevisionsController < ApplicationController 
  def new 
    @project = Project.find(params[:project_id])
    @amount_revision = @project.amount_revisions.build
  end

  def create
    @project = Project.find(params[:project_id])
    @amount_revision = @project.amount_revisions.build(amount_revision_params)
      if @amount_revision.save 
      redirect_to @project, notice: "Project Amount  revised to #{ view_context.number_to_currency(@amount_revision.revised_contract_amount) }"
    else
      render :new 
    end
  end

  private 
  def amount_revision_params
    params.require(:amount_revision).permit(:revised_contract_amount)
  end
end
