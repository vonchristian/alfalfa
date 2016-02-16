class ConstructionEquipments::DepreciationsController < ApplicationController
  def new
    @construction_equipment = ConstructionEquipment.find(params[:construction_equipment_id])
    @depreciation = @construction_equipment.depreciations.build
  end

  def create
    @construction_equipment = ConstructionEquipment.find(params[:construction_equipment_id])
    @depreciation = @construction_equipment.depreciations.create(depreciation_params)
    if @depreciation.valid?
      @depreciation.depreciate_asset
      @depreciation.save
      redirect_to @construction_equipment, notice: "Depreciation recorded successfully."
    else
      render :new
    end
  end
  private
  def depreciation_params
    params.require(:depreciation).permit(:amount)
end
end
