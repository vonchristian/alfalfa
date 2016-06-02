
  class EquipmentController < ApplicationController
    layout "supplies"
    def index
      authorize User, :index?
      @equipments = EquipmentDecorator.decorate_collection(Equipment.all.order('created_at DESC').page(params[:page]).per(50))
    end
    def new
      @equipment = Equipment.new
      authorize @equipment
    end

    def create
      @equipment = Equipment.create(equipment_params)
      authorize @equipment
      if @equipment.save
        @equipment.set_equipment_status
        redirect_to @equipment, notice: "Equipment saved successfully."
      else
        render :new
      end
    end

    def show
      @equipment = Equipment.find(params[:id])
      authorize @equipment
      @equipment_schedules = @equipment.equipment_schedules.all.order('created_at DESC').page(params[:page]).per(10)
    end

    def edit
      @equipment = Equipment.find(params[:id])
      authorize @equipment
    end

    def update
      @equipment = Equipment.find(params[:id])
      authorize @equipment
      if @equipment.update(equipment_params)
        redirect_to @equipment, notice: 'Equipment updated successfully.'
      else
        render :edit
      end
    end

    private
    def equipment_params
      params.require(:equipment).permit(:photo, :make, :model, :chassis_number, :engine_number, :plate_number, :acquisition_cost, :acquisition_date)
    end
  end
