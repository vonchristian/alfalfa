module Monitoring
  class EquipmentController < ApplicationController
layout "monitoring"
    def index
      @equipments = Equipment.all
    end
  end
end
