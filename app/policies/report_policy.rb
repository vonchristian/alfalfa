class ReportPolicy < ApplicationPolicy
  attr_reader :user, :report

  def initialize(user, report)
    @user = user
    @report = report
  end

  def show?
    user.supply_officer?
  end
end
