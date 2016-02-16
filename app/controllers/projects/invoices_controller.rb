class Projects::InvoicesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @invoice = @project.invoices.build
  end

  def create
    @project = Project.find(params[:project_id])
    @invoice = @project.invoices.create(invoice_params)
    if @invoice.valid?
      @invoice.update_accounts
      @invoice.save
      redirect_to @project, notice: "Invoice saved successfully"
    else
      render :new
    end
  end
  private
  def invoice_params
    params.require(:invoice).permit(:amount)
  end
end
