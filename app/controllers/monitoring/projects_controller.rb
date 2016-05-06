module Monitoring
  class ProjectsController < ApplicationController
    layout "monitoring"
    def index
      if params[:name].present?
        @projects = Project.search_by_name(params[:name])
      else
        @projects = Project.all
      end
    end
    def show
      @project = Project.find(params[:id])
    end
  end
end
