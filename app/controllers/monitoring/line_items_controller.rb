module Monitoring
	class LineItemsController < ApplicationController
		layout "monitoring"
		def index
			if params[:name].present?
	      @projects = Project.search_by_name(params[:name])
	    else
	      @projects = Project.all
	    end
			@project = Project.find(params[:project_id])
			@line_items = @project.line_items.order(date: :desc).all
			respond_to do |format|
				format.html
				format.pdf do
					pdf = MonitoringProjectLineItemsPdf.new(@project, @line_items view_context)
          			send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
				end
			end
		end
	end
end
