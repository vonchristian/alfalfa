module Supplies
  class Inventory < ActiveRecord::Base
    include PublicActivity::Common
    include PgSearch
    pg_search_scope :search_by_name, :against => [:name]
    enum status:[:available, :unavailable, :discontinued]
    has_many :stocks
    has_many :line_items, class_name: 'Supplies::LineItem'
    has_many :orders, through: :line_items, class_name: 'Supplies::Order'

    validates :name, :unit, :price, presence: true
    validates :price, numericality: { greater_than: 0.1 }

    accepts_nested_attributes_for :stocks
    def discontinue
      self.discontinued!
    end

    def check_if_out_of_stock
      if out_of_stock?
        unavailable!
      end
    end

    def quantity
      stocks.all.sum(:quantity) - line_items.all.sum(:quantity)
    end

    def quantity_and_unit
      "#{quantity} #{unit}"
    end

    def out_of_stock?
      quantity.zero? || quantity.negative?
    end

    def current_inventory_quantity
      quantity
    end

    def to_s
      "#{name} - #{description}"
    end

    def name_description
      "#{name} - #{description}"
    end

    def total_cost
      quantity * cost
    end

  end
end
