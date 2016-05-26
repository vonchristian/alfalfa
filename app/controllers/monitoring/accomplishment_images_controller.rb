module Monitoring
  class AccomplishmentImagesController  < ApplicationController
    layout "monitoring"
    def show
      @accomplishment_image = AccomplishmentImage.find(params[:id])
    end
  end
end
