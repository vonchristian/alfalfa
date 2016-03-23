class ReportsController < ApplicationController
  def contract_summary_report
   @projects = ProjectDecorator.decorate_collection(Project.all)
   respond_to do |format|
    format.html
     format.pdf do
      pdf = ContractSummaryReportPdf.new(@projects, view_context)
      send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Contract Summary Report.pdf"
  end
end

  end
end
