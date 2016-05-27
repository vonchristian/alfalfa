class CashFlowPolicy < Struct.new(:user, :cash_flow)
  attr_reader :user, :cash_flow

  def initialize(user, cash_flow)
    @user = user
    @cash_flow = cash_flow
  end

  def show?
      user.accounting_officer?
    end

end
