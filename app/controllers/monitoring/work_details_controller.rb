module Monitoring
  class WorkDetailsController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
      @work_details = @project.work_details.page(params[:page]).per(50)
      respond_to do |format|
        format.html
        format.pdf do
          pdf =  StatementOfWorkAccomplishedPdf.new(@project, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Entries Report.pdf"
        end
      end
    end
    def new
      @project = Project.find(params[:project_id])
      @work_detail = @project.work_details.build
      authorize @work_detail
    end

    def create
      @project = Project.find(params[:project_id])
      @work_details = WorkDetail.all
      @work_detail = @project.work_details.create(work_detail_params)
      authorize @work_detail
    end

    def edit
      @work_detail = WorkDetail.find(params[:id])
      authorize @work_detail
    end

    def update
      @work_detail = WorkDetail.find(params[:id])
      @work_details = WorkDetail.all
      @work_detail.update_attributes(work_detail_params)
    end

    def destroy
      @project = Project.find(params[:project_id])
      @work_detail = WorkDetail.find(params[:id])
      authorize @work_detail
    end

    def show
      @work_detail = WorkDetail.includes(:work_accomplishments).find(params[:id]).decorate
      authorize @work_detail
    end

    private
    def work_detail_params
      params.require(:work_detail).permit(:code, :description, :unit, :unit_cost, :quantity, :total_cost)
    end
  end
end
