class FundTransferPolicy < ApplicationPolicy
  attr_reader :current_user, :fund_transfer

  def initialize(user, fund_transfer)
    @user = user
    @fund_transfer = fund_transfer
  end



  def index?
    true
  end

  def show?
   true
  end

  def create?
  user.accounting_officer? || user.owner?
  end

  def new?
    create?
  end

  def edit?
    user.accounting_officer? || user.owner?
  end

  def update?
    edit?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    def resolve
      scope
    end
  end
end

