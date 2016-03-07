class Account < ActiveRecord::Base

  class_attribute :normal_credit_balance

    has_many :credit_amounts, :extend => AmountsExtension, class_name: "CreditAmount"
    has_many :debit_amounts, :extend => AmountsExtension, class_name: "DebitAmount"
    has_many :credit_entries, :through => :credit_amounts, :source => :entry
    has_many :debit_entries, :through => :debit_amounts, :source => :entry

    validates_presence_of :type
    validates :code, :name, presence: true, uniqueness: true
  def self.fund_transfer_sources
self.where(name: FundTransfer::FUND_SOURCE)
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

