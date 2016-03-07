class ConstructionEquipmentsController < ApplicationController
  def index
  end
  def new
    @construction_equipment = ConstructionEquipment.new
  end

  def create
    @construction_equipment = ConstructionEquipment.create(construction_equipment_params)
    if @construction_equipment.valid?
      @construction_equipment.add_to_fixed_asset_accounts
      @construction_equipment.save
      @construction_equipment.create_activity :create, owner: current_user, recipient: @project
      redirect_to @construction_equipment, notice: "Equipment saved successfully."
    else
      render :new
    end
  end

  def show
    @construction_equipment = ConstructionEquipment.find(params[:id])
  end

  private
  def construction_equipment_params
    params.require(:construction_equipment).permit(:equipment_type, :purchase_price, :make, :model, :plate_number, images_files: [])
  end
end
