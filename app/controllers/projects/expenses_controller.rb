class Projects::ExpensesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @expense = @project.expenses.build
  end

  def create
    @project = Project.find(params[:project_id])
    @expense = @project.expenses.build(expense_params)
    if @expense.save
      redirect_to @project, notice: "Expense recorded successfully."
    else
      render :new
    end
  end

  private
  def expense_params
    params.require(:expense).permit(:amount, :description)
  end
end
