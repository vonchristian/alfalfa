module Monitoring
  class EquipmentController < ApplicationController
		layout "monitoring"
    def index
      @equipments = EquipmentDecorator.decorate_collection(Equipment.all)
    end
  end
end
