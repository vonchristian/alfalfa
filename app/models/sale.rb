class Sale < ActiveRecord::Base
  belongs_to :inventory

  def update_accounts
    Entry.create!(date: self.date, description: "Sale of #{self.quantity} #{self.inventory.unit} #{self.inventory.name}", debit_amounts_attributes:[amount: (self.amount), account: "Petty Cash"],
                        credit_amounts_attributes:[amount: (self.amount), account: "Inventory"])
  end

  def self.entered_on(hash={})
    if hash[:from_date] && hash[:to_date]
      from_date = hash[:from_date].kind_of?(Time) ? hash[:from_date] : Time.parse(hash[:from_date].strftime('%Y-%m-%d 12:00:00'))
      to_date = hash[:to_date].kind_of?(Time) ? hash[:to_date] : Time.parse(hash[:to_date].strftime('%Y-%m-%d 12:59:59'))
      Sale.where('date' => from_date..to_date)
    else
      Sale.all
    end
  end

  def self.today
    where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

end
