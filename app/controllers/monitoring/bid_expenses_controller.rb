module Monitoring
	class BidExpensesController < ApplicationController
		layout "monitoring"

		def index
      @project = Project.find(params[:project_id])
      @bid_expenses = @project.bid_expenses.all
    end

		def new
      @project = Project.find(params[:project_id])
      @bid_expense = @project.bid_expenses.build 
      authorize @bid_expense
    end

    def edit
      @project = Project.find(params[:project_id])
      @bid_expense = Project::BidExpense.find(params[:id])
      authorize @bid_expense
    end

    def create
      @project = Project.find(params[:project_id])
      @bid_expense = @project.bid_expenses.create(bid_expense_params)
      authorize @bid_expense
      if @bid_expense.save
        # @bid_expense.create_activity :create, owner: current_user, recipient: @project
        redirect_to monitoring_project_path(@project), notice: "Bid Expense saved successfully."
      else
        render :new
      end
    end

    def update
      @project = Project.find(params[:project_id])
      @bid_expense = Project::BidExpense.find(params[:id])
      authorize @bid_expense
      @bid_expense.update(bid_expense_params)
      if @bid_expense.save
        # @bid_expense.create_activity :update, owner: current_user, recipient: @project
        redirect_to monitoring_project_bid_expenses_path(@bid_expense.project), notice: "Bid Expense updated successfully."
      else
        render :edit
      end
    end

    def show
      @bid_expense = Project::BidExpense.find(params[:id])
    end

    private

    def bid_expense_params
      params.require(:bid_expense).permit(:date, :amount, :description)
    end
  end
end
