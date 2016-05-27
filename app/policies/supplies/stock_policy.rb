module Supplies
  class StockPolicy < ApplicationPolicy
    attr_reader :current_user, :stock

    def initialize(user, stock)
      @user = user
      @stock = stock
    end

    def index?
      create?
    end

    def show?
     create?
    end

    def create?
    user.supply_officer?
    end

    def new?
      create?
    end

    def edit?
      user.supply_officer?
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
