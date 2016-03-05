class Plutus::EntryPolicy < ApplicationPolicy

 attr_reader :user, :entry

  def initialize(user, entry)
    @user = user
    @entry = entry
  end

  def show?
    true
  end

  def create?
  user.accounting_officer?
  end

  def edit?
    user.accounting_officer?
  end

  def update?
    edit?
  end

  def new?
    create?
  end

  def destroy?
    false
  end
end
