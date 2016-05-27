class AccountingPolicy < Struct.new(:user, :accounting)
  attr_reader :user, :accounting

  def initialize(user, post)
    @user = user
    @accounting = accounting
  end

  def show?
      user.project_engineer? || user.monitoring_officer? || user.liason_officer? || user.project_manager?
    end
end
