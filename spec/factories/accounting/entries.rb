FactoryGirl.define do
  factory :entry, class: "Accounting::Entry"  do |entry|
    entry.description 'factory description'
    entry.date Date.today
    factory :entry_with_credit_and_debit do |entry_cd|
      entry_cd.after(:create) do |t|
        t.credit_amounts << FactoryGirl.build(:credit_amount, :entry => t)
        t.debit_amounts << FactoryGirl.build(:debit_amount, :entry => t)
      end
    end
  end
end
