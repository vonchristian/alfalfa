module Monitoring
  class AmountRevisionsController < ApplicationController
    layout "monitoring"
    def index
      @project = Project.find(params[:project_id])
      @amount_revisions = @project.amount_revisions
    end
  end
end
