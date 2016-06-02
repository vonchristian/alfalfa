module Supplies
  class EquipmentSchedulesController < ApplicationController
    layout "supplies"
    def index
      @equipment_schedules = EquipmentSchedule.all.order('created_at DESC').page(params[:page]).per(10)
    end
  end
end
