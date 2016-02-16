class LandsController < ApplicationController
 def new
    @land = Land.new
  end

  def create
    @land = Land.create(land_params)
    if @land.valid?
      @land.add_to_fixed_asset_accounts
      @land.save
      redirect_to assets_path, notice: "Asset saved successfully."
    else
      render :new
    end
  end

  private
  def land_params
    params.require(:land).permit(:cost, :area)
  end
end
