module Monitoring
  class FileAttachmentsController < ApplicationController
    # before_action :set_file_attachment, only: [:edit, :update]
  layout "monitoring"
    def new
      @project = Project.find(params[:project_id])
      @file_attachment = @project.file_attachments.build
      authorize @file_attachment
    end

    def edit
      @project = Project.find(params[:project_id])
      @file_attachment = @project.file_attachments.build
      authorize @file_attachment
    end

    def create
      @project = Project.find(params[:project_id])
      @file_attachment = @project.file_attachments.create(file_attachment_params)
      authorize @file_attachment
      if @file_attachment.save
        # @file_attachment.create_activity :create, owner: current_user, recipient: @project
        redirect_to monitoring_project_path(@project), notice: "File Attachment saved successfully."
      else
        render :new
      end
    end

    def update
      @project = Project.find(params[:project_id])
      @file_attachment = Project::FileAttachment.find(params[:id])
      authorize @file_attachment
      @file_attachment.update(file_attachment_params)
      if @file_attachment.save
        # @file_attachment.create_activity :update, owner: current_user, recipient: @project
        redirect_to @file_attachment.project, notice: "File Attachment updated successfully."
      else
        render :edit
      end
    end

    private

    def file_attachment_params
      params.require(:file_attachment).permit(:attached_file, :date, :description)
    end
  end
end