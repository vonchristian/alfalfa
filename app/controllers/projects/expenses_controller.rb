class Projects::ExpensesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @entry = Plutus::Entry.new
    @entry.credit_amounts.build
    @entry.debit_amounts.build
  end

  def create
    @project = Project.find(params[:project_id])
    @entry = Plutus::Entry.new(entry_params)
    @entry.commercial_document = @project
    @entry.owner_id = current_user.id
    if @entry.save
      redirect_to @project, notice: "Expense Recorded successfully"
    else
      render :new
    end
  end

  def show
    @entry = Plutus::Entry.find(params[:id])
  end
  private
  def entry_params
    params.require(:entry).permit(:description, :owner_id, :recipient_id, :credit_amounts_attributes=> [:amount, :account], :debit_amounts_attributes=> [:amount, :account])
  end
end
