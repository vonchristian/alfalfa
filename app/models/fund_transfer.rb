class FundTransfer < ActiveRecord::Base
  FUND_SOURCE = ["Cash on Hand", "Owner's Capital", "Cash in Bank"]
  belongs_to :source_account, class_name: "Account"
  belongs_to :recipient_account, class_name: "Account"

  enum fund_transfer_type:[:cash, :check]

  validates :amount, :date, :source_account_id, :recipient_account_id, presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 1_000 }

  def update_accounts
    Entry.create!(date: self.date, recipient_id: self.recipient_account.id, description: self.description,
                       debit_amounts_attributes:[{amount: (self.amount), account: self.recipient_account.name}],
                       credit_amounts_attributes:[amount: (self.amount), account: self.source_account.name ])
   end
end
