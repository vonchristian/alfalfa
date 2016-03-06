class FundTransfersController < ApplicationController
  def new
    @fund_transfer = FundTransfer.new
  end
end
