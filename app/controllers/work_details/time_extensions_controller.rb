class WorkDetails::TimeExtensionsController < ApplicationController
  layout 'monitoring'
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @time_extension = @work_detail.time_extensions.build
    authorize @time_extension
  end

  def create
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @time_extension = @work_detail.time_extensions.create(time_extension_params)
    authorize @time_extension
    if @time_extension.save
      redirect_to @work_detail, notice: "Work Detail extended for #{@time_extension.number_of_days} days."
    else
      render :new
    end
  end

  private
  def time_extension_params
    params.require(:change_orders_time_extension).permit(:number_of_days, :remarks, :date)
  end
end
