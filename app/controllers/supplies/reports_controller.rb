class Supplies::ReportsController  < ApplicationController
  layout 'supplies'
  def index 
    if params[:name].present?
      @projects = Project.search_by_name(params[:name])
    else
      @projects = Project.all
    end
    
    @orders = Supplies::Order.all
    @project = Project.find(params[:project_id]) if params[:project_id].present?
    respond_to do |format|
      format.html
      format.pdf do
        pdf = IssuedInventoryPdf.new(@orders, @project, @from_date, @to_date, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "IssuedMaterials.pdf"
      end
    end
  end
end
