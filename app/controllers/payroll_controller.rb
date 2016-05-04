class PayrollController < ApplicationController
  layout "accounting"
def index
end

def show
@employee = Employee.find(params[:id])
end
end
