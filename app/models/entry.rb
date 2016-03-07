class Entry < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch
  multisearchable :against => [:description, :recipient_name]
    belongs_to :entriable, :polymorphic => true
    belongs_to :recipient, class_name: 'Employee', foreign_key: 'recipient_id'
    has_many :credit_amounts, :extend => AmountsExtension, :class_name => 'CreditAmount', :inverse_of => :entry
    has_many :debit_amounts, :extend => AmountsExtension, :class_name => 'DebitAmount', :inverse_of => :entry
    has_many :credit_accounts, :through => :credit_amounts, :source => :account, :class_name => 'Account'
    has_many :debit_accounts, :through => :debit_amounts, :source => :account, :class_name => 'Account'

    validates_presence_of :description
    validate :has_credit_amounts?
    validate :has_debit_amounts?
    validate :amounts_cancel?

    # Support construction using 'credits' and 'debits' keys
    accepts_nested_attributes_for :credit_amounts, :debit_amounts

    delegate :name, to: :recipient, prefix: true

    before_save :set_default_date

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
