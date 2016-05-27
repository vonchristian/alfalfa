class MonitoringController < ApplicationController
  layout "monitoring"
  def index
    @projects = ProjectDecorator.decorate_collection(Project.all.order(:created_at).reverse)
    authorize :monitoring, :show?
  end
end
