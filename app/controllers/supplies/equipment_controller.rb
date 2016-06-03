module Supplies
  class EquipmentController < ApplicationController
    layout 'supplies'
    def index
      authorize User, :index?
      if params[:query].present?
        @equipments = Equipment.search_by_name(params[:query]).order(:created_at).decorate
      else
        @equipments = EquipmentDecorator.decorate_collection(Equipment.all.order('created_at DESC').page(params[:page]).per(50))
      end
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
