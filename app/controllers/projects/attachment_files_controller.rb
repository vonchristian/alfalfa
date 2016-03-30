class Projects::AttachmentFilesController < ApplicationController

  def show
    @attachment_file = AttachmentFile.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @attachment_file = @project.attachment_files.build
    authorize @attachment_file
  end

  def create
    @project = Project.find(params[:project_id])
    @attachment_file = @project.attachment_files.create(attachment_params)
    authorize @attachment_file
    if @attachment_file.save
      redirect_to @project, notice: 'Employee has been added succesfully.'
    else
      render :new
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @attachment_file = AttachmentFile.find(params[:id])
    authorize @attachment_file
    @attachment_file.destroy
    redirect_to @attachment_file.project, notice: 'Employee has been removed succesfully.'
  end

  private
    def attachment_params
      params.require(:attachment_file).permit(:description, :attachment_report)
    end
end
