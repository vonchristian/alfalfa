module Supplies
  class ProjectsController < ApplicationController
    layout 'supplies'

    def show
      @project = Project.find(params[:id])
      respond_to do |format|
				format.html
				format.pdf do
					pdf = ProjectLineItemsPdf.new(@project, view_context)
          			send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
				end
			end
    end
  end
end
