module Supplies
  class ProjectsController < ApplicationController
    layout 'supplies'
    def show
      @project = Project.find(params[:id])
    end
  end
end
