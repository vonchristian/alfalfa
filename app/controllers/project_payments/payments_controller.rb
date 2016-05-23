module ProjectPayments
  class PaymentsController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
    end
  end
end
