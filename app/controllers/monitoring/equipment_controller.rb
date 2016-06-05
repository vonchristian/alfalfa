module Monitoring
  class EquipmentController < ApplicationController
		layout "monitoring"
    def index
      @equipments = EquipmentDecorator.decorate_collection(Equipment.all)
    end
    def show
      @equipment = Equipment.find(params[:id]).decorate
    end
  end
end
