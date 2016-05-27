
  class AccountPolicy < ApplicationPolicy
    attr_reader :current_user, :account

    def initialize(user, account)
      @user = user
      @account = account
    end


    def index?
      create?
    end

    def show?
     create?
    end

    def create?
    user.accounting_officer?
    end

    def new?
      create?
    end

    def edit?
      user.accounting_officer?
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
