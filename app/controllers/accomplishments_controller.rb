class AccomplishmentsController < ApplicationController 
 def new 
    @project = Project.find(params[:project_id])
    @accomplishment = @project.accomplishments.build
  end

  def create
    @project = Project.find(params[:project_id])
    @accomplishment = @project.accomplishments.build(accomplishment_params)
      if @accomplishment.save 
        @accomplishment.create_activity :create, owner: current_user, recipient: @project
      
      redirect_to @project, notice: "Project accomplishment marked at #{@accomplishment.percent} %."
    else
      render :new 
    end
  end

  private 
  def accomplishment_params
    params.require(:accomplishment).permit(:percent)
  end
end

