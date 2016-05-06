module Monitoring
  class CollectionsController < ApplicationController
    layout "monitoring"
    def index
      @projects = Project.all
      @collections = Collection.all
    end
  end
end
