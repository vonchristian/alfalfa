module Monitoring
  class ContractorsController < ApplicationController
    layout "monitoring"
    def index
      if params[:query].present?
        @contractors = Contractor.search_by_name(params[:query])
      else
        @contractors = Contractor.all
      end
      authorize User
    end
  end
end
