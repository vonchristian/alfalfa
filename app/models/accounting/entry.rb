module Accounting
  class Entry < ActiveRecord::Base
    include PublicActivity::Common
    include PgSearch
    multisearchable :against => [:description]

    belongs_to :entriable, :polymorphic => true
    has_many :amounts
    has_many :credit_amounts, :extend => AmountsExtension, :class_name => 'CreditAmount', :inverse_of => :entry, dependent: :destroy
    has_many :debit_amounts, :extend => AmountsExtension, :class_name => 'DebitAmount', :inverse_of => :entry, dependent: :destroy
    has_many :credit_accounts, :through => :credit_amounts, :source => :account, :class_name => 'Account'
    has_many :debit_accounts, :through => :debit_amounts, :source => :account, :class_name => 'Account'
    validates_presence_of :description, :date
    validate :has_credit_amounts?
    validate :has_debit_amounts?
    validate :amounts_cancel?

    # Support construction using 'credits' and 'debits' keys
    accepts_nested_attributes_for :credit_amounts, :debit_amounts
    validates_associated :credit_amounts, :debit_amounts


    before_save :set_default_date
    def self.types
      ["CashAdvance", "Disbursement", "FundTransfer", "SalaryPayment", "BankWithdraw", "BankDeposit"]
    end
    def name
      description
    end

    def self.entered_on(hash={})
      if hash[:from_date] && hash[:to_date]
        from_date = hash[:from_date].kind_of?(Time) ? hash[:from_date] : Time.parse(hash[:from_date].strftime('%Y-%m-%d 12:00:00'))
        to_date = hash[:to_date].kind_of?(Time) ? hash[:to_date] : Time.parse(hash[:to_date].strftime('%Y-%m-%d 12:59:59'))
        Accounting::Entry.where('date' => from_date..to_date)
      else
        Accounting::Entry.all
      end
    end


    private
    def set_default_date
      self.date ||= Time.zone.now
    end

    def has_credit_amounts?
      errors[:base] << "Entry must have at least one credit amount" if self.credit_amounts.blank?
    end

    def has_debit_amounts?
      errors[:base] << "Entry must have at least one debit amount" if self.debit_amounts.blank?
    end

    def amounts_cancel?
      errors[:base] << "The credit and debit amounts are not equal" if credit_amounts.balance_for_new_record != debit_amounts.balance_for_new_record
    end
  end
end
