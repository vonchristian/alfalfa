module Monitoring
  class ContractorsController < ApplicationController
    layout "monitoring"
    def index
      @contractors = Contractor.all
    end
  end
end
