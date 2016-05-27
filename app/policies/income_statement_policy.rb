class IncomeStatementPolicy < Struct.new(:user, :income_statement)
  attr_reader :user, :income_statement

  def initialize(user, income_statement)
    @user = user
    @income_statement = income_statement
  end

  def show?
      user.accounting_officer?
    end

end
