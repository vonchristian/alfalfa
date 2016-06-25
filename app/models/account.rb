class Account < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, :against => [:code, :name, :type]
  FUND_TRANSFER_SOURCES = ["Owner's Capital", "Cash on Hand", "Cash in Bank"]
  EMPLOYEE_EXPENSES_SOURCES = ["Advances to Employees",
                               "Employee Wages and Salaries",
                               "Advances to Employees (PPE)"]
  PROJECT_EXPENSES_SOURCES = ["Materials", "Labor", "Equipment","Subcontract", "Other Costs"]
  EQUIPMENT_EXPENSES_SOURCES = ["Rent and Lease Payments",
                                "Depreciation",
                                "Repairs",
                                "Maintenance",
                                "Tires",
                                "Miscellaneous",
                                "Fuel and Lubrication",
                                "Taxes, Licenses and Insurance",
                                "Equipment Cost Charged to Employee",
                                "Equipment Cost Charged to Jobs"]
  OFFICE_EXPENSES_SOURCES = ["Computer and Office Furniture", "Office Supplies", "Office Purchase", "Office Rent", "Office Utilities", "Postage and Delivery", "Janitorial and Cleaning", "Telephone", "Meals and Entertainment"]
  CASH_SOURCES = ["Cash on Hand", "Petty Cash", "Cash in Bank"]
  CASH_SOURCES_WITH_INVENTORY = ["Cash on Hand", "Petty Cash", "Cash in Bank", "Inventory"]

  class_attribute :normal_credit_balance
    has_many :amounts
    has_many :credit_amounts, :extend => AmountsExtension, class_name: "CreditAmount"
    has_many :debit_amounts, :extend => AmountsExtension, class_name: "DebitAmount"
    has_many :credit_entries, :through => :credit_amounts, :source => :entry
    has_many :debit_entries, :through => :debit_amounts, :source => :entry
    has_many :entries, through: :amounts, source: :entry
    validates_presence_of :type
    validates :code, :name, presence: true, uniqueness: true

  def self.fund_transfer_sources
     self.all.select{|a| Account::FUND_TRANSFER_SOURCES.include?(a.name)}
  end

  def self.employee_expenses_sources
     self.all.select{|a| Account::EMPLOYEE_EXPENSES_SOURCES.include?(a.name)}
  end

  def self.office_expenses_sources
     self.all.select{|a| Account::OFFICE_EXPENSES_SOURCES.include?(a.name)}
  end

  def self.project_expenses_sources
    self.all.select{|a| Account::PROJECT_EXPENSES_SOURCES.include?(a.name)}
  end
  def self.equipment_expenses_sources
    self.all.select{|a| Account::EQUIPMENT_EXPENSES_SOURCES.include?(a.name)}
  end

  def self.petty_cash_expenses
    self.all.select{|a| Account::PETTY_CASH_EXPENSES.include?(a.name)}
  end

  def balance(options={})
    if self.class == Account
      raise(NoMethodError, "undefined method 'balance'")
    else
      if self.normal_credit_balance ^ contra
        credits_balance(options) - debits_balance(options)
      else
        debits_balance(options) - credits_balance(options)
      end
    end
  end

  def credits_balance(options={})
    credit_amounts.balance(options)
  end


  def debits_balance(options={})
    debit_amounts.balance(options)
  end


  def self.balance(options={})
    if self.new.class == Account
      raise(NoMethodError, "undefined method 'balance'")
    else
      accounts_balance = BigDecimal.new('0')
      accounts = self.all
      accounts.each do |account|
        if account.contra
          accounts_balance -= account.balance(options)
        else
          accounts_balance += account.balance(options)
        end
      end
      accounts_balance
    end
  end


  def self.trial_balance
    if self.new.class == Account
      Asset.balance - (Liability.balance + Equity.balance + Revenue.balance - Expense.balance)
    else
      raise(NoMethodError, "undefined method 'trial_balance'")
    end
  end
end
