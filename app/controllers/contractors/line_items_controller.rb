module Contractors
	class LineItemsController < ApplicationController 
		def index
			if params[:contractor_name].present?
	      @contractors = Contractor.search_by_name(params[:contractor_name])
	    else
	      @contractors = Contractor.all
	    end
			@contractor = Contractor.find(params[:contractor_id])
			@line_items = @contractor.line_items.order(date: :desc).all
			respond_to do |format|
				format.pdf do 
					pdf = MonitoringContractorLineItemsPdf.new(@contractor, @line_items, view_context)
          			send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
				end
			end
		end
	end
end
# @issued_inventories = IssuedInventory.all
# @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
# @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
# @project = Project.find(params[:project_id]) if params[:project_id].present?
# respond_to do |format|
#   format.html
#   format.pdf do
#     pdf = IssuedInventoryPdf.new(@issued_inventories, @project, @from_date, @to_date, view_context)
#       send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
#   end
# end