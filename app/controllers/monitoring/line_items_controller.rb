module Monitoring
	class LineItemsController < ApplicationController
		def index
			if params[:name].present?
	      @projects = Project.search_by_name(params[:name])
	    else
	      @projects = Project.all
	    end
			@project = Project.find(params[:project_id])
			respond_to do |format|
				format.pdf do
					pdf = ProjectLineItemsPdf.new(@project, view_context)
          			send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
				end
			end
		end
	end
end
