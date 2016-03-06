class Amount < ActiveRecord::Base
    belongs_to :entry, :class_name => 'Entry'
    belongs_to :account, :class_name => 'Account'

    validates_presence_of :type, :amount, :entry, :account
    # attr_accessible :account, :account_name, :amount, :entry

    # Assign an account by name
    def account_name=(name)
      self.account = Account.find_by_name!(name)
    end

    protected

    # Support constructing amounts with account = "name" syntax
    def account_with_name_lookup=(v)
      if v.kind_of?(String)
        ActiveSupport::Deprecation.warn('Plutus was given an :account String (use account_name instead)', caller)
        self.account_name = v
      else
        self.account_without_name_lookup = v
      end
    end
    alias_method_chain :account=, :name_lookup
  end

