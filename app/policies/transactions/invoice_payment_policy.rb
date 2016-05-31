class Transactions::InvoicePaymentPolicy < ApplicationPolicy
  attr_reader :current_user, :invoice_payment

  def initialize(user, invoice_payment)
    @user = user
    @invoice_payment = invoice_payment
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
