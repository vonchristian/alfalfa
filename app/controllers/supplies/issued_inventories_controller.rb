class Supplies::IssuedInventoriesController  < ApplicationController
  layout 'supplies'
  def index
    @project = Project.find(params[:id])
    respond_to do |format|
      format.pdf do
        pdf = IssuedInventoryPdf.new(@project, @from_date, @to_date, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
      end
    end
  end
end
