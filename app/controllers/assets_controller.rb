class AssetsController < ApplicationController
  def index
    @asset = Plutus::Asset.all
  end
	def show
		@asset = Plutus::Asset.find(params[:id])
	end
end
