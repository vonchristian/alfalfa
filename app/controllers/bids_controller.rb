class BidsController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
    @bid = @project.bids.build
  end

  def create
    @project = Project.find(params[:project_id])
    @bid = @project.bids.create(bid_params)
    if @bid.save
      redirect_to @project, notice: "Contractor added successfully."
    else
      render :new
    end
  end

  private
  def bid_params
    params.require(:bid).permit(bidder_ids:[], document_ids:[])
  end
end
