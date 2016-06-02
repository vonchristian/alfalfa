module Supplies
  class EquipmentController < ApplicationController
    layout 'supplies'
    def index
      authorize User, :index?
      @equipments = EquipmentDecorator.decorate_collection(Equipment.all.order('created_at DESC').page(params[:page]).per(50))
    end
    def active
      authorize User, :index?
      @equipments = EquipmentDecorator.decorate_collection(Equipment.active)
    end
    def inactive
      authorize User, :index?
      @equipments = EquipmentDecorator.decorate_collection(Equipment.inactive)
    end
  end
end
