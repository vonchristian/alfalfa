class BidExpensePolicy < ApplicationPolicy

  attr_reader :current_user, :bid_expense

  def initialize(user, bid_expense)
    @user = user
    @bid_expense = bid_expense
  end

  def show?
    true
  end

  def create?
    user.project_engineer? || user.monitoring_officer? || user.liason_officer? || user.project_manager?
  end

  def edit?
    user.project_engineer? || user.monitoring_officer? || user.liason_officer? || user.project_manager?
  end

  def update?
    edit?
  end

  def new?
    create?
  end

  def destroy?
    user.project_engineer? || user.monitoring_officer? || user.liason_officer? || user.project_manager?
  end
end