class FundTransfer < ActiveRecord::Base
  belongs_to :source_account, class_name: "Account"
  belongs_to :recipient_account, class_name: "Account"

  enum fund_transfer_type:[:cash, :check]

  validates :amount, :date, :source_account_id, :recipient_account_id, presence: true

  def update_accounts
    Entry.create!(description: "Fund Transfer from #{self.source_account.name} Account to #{self.recipient_account.name} Account",
                       debit_amounts_attributes:[{amount: (self.amount), account: self.recipient_account.name}],
                       credit_amounts_attributes:[amount: (self.amount), account: self.source_account.name ])
   end
end
