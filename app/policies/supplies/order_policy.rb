module Supplies
    class OrderPolicy < ApplicationPolicy
    attr_reader :user, :order

    def initialize(user, order)
      @user = user
      @order = order
    end

    def index
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
      create?
    end

    def update?
      create?
    end

    def destroy?
      false
    end

    class Scope
      attr_reader :user, :scope

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
