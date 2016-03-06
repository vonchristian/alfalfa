class PettyCash < Asset
  has_many :disbursements, class_name: 'Entry', foreign_key: 'entriable_id'
  has_many :fund_transfers

end
