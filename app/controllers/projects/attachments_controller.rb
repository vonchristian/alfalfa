class Projects::AttachmentsController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
    @attachment = @project.attachments.build
    authorize @attachment
  end

  def create
    @project = Project.find(params[:project_id])
    @attachment = @project.attachments.create(attachment_params)
    authorize @attachment
    if @attachment.save
      redirect_to @project, notice: 'Employee has been added succesfully.'
    else
      render :new
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @attachment = Attachment.find(params[:id])
    authorize @attachment
    @attachment.destroy
    redirect_to @attachment.project, notice: 'Employee has been removed succesfully.'
  end

  private
    def attachment_params
      params.require(:attachment).permit(:description, :attachment_file)
    end
end
