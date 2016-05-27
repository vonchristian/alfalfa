class PayrollPolicy < ApplicationPolicy
  attr_reader :user, :payroll

  def initialize(user, payroll)
    @user = user
    @payroll = payroll
  end

  def show?
      user.accounting_officer?
    end

end
