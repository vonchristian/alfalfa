module Monitoring
  module Projects
    class PaymentsController < ApplicationController
      def index
        @project = Project.find(params[:id])
      end
      
    end
  end
end
