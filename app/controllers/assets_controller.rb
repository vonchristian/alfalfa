class AssetsController < ApplicationController
	def show
		@asset = Plutus::Asset.find(params[:id])
	end
end
