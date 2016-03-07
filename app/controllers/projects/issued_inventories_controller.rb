class Projects::IssuedInventoriesController < ApplicationController
  def new
    @work_detail = WorkDetail.find(params[:work_detail_id])
    @issued_inventory = @work_detail.issued_inventories.build
    authorize @issued_inventory
  end
end
