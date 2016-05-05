module Accounting
  class EntryPolicy < ApplicationPolicy
    attr_reader :current_user, :entry

    def initialize(user, entry)
      @user = user
      @entry = entry
    end


    def index?
      true
    end

    def show?
     true
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
end
