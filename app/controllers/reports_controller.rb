class ReportsController < ApplicationController
  def contract_summary_report
   @projects =ProjectDecorator.decorate_collection(Project.all)

  end
end
