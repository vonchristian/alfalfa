class WorkDetailsController < ApplicationController
  def show
    @work_detail = WorkDetail.find(params[:id]).decorate
  end
end
