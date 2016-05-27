module Accounting
  class CashFlowController < ApplicationController
    layout "accounting"
    def index
      authorize :cash_flow, :show?
    end
  end
end
