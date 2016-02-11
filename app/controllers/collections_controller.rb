class CollectionsController < ApplicationController 
  def new 
    @project = Project.find(params[:project_id])
    @collection = @project.collections.build 
  end

  def create
    @project = Project.find(params[:project_id])
    @collection = @project.collections.create(collection_params)
    if @collection.save 
      @collection.create_activity :create, owner: current_user, recipient: @project
      redirect_to @project, notice: "Collection recorded successfully."
    else
      render :new 
    end
  end

  private 
  def collection_params
    params.require(:collection).permit(:date, :amount)
  end
end
