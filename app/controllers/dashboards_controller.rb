class DashboardsController < ApplicationController
  def dashboard
    @projects = Project.all
  end
end
