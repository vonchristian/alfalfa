module Monitoring
  class PaymentsController < ApplicationController
    layout "monitoring"
    def index
      @projects = Project.all
    end
  end
  def show
    @project = Project.find(params[:project_id])
  end
end
