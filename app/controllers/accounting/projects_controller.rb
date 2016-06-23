module Accounting
  class ProjectsController < ApplicationController
    layout 'accounting'
    def show
      @project = Project.find(params[:id])
    end
  end
end
