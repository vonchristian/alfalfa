module AmountsExtension
    def balance(hash={})
      if hash[:from_date] && hash[:to_date]
        from_date = hash[:from_date].kind_of?(Date) ? hash[:from_date] : Date.parse(hash[:from_date])
        to_date = hash[:to_date].kind_of?(Date) ? hash[:to_date] : Date.parse(hash[:to_date])
        includes(:entry).where('entries.date' => from_date..to_date).sum(:amount)
      else
        sum(:amount)
      end
    end

    # Returns a sum of the referenced Amount objects.
    #
    # This is used primarly in the validation step in Plutus::Entry
    # in order to ensure that the debit and credits are canceling out.
    #
    # Since this does not use the database for sumation, it may be used on non-persisted records.
    def balance_for_new_record
      balance = BigDecimal.new('0')
      each do |amount_record|
        if amount_record.amount
          balance += amount_record.amount
        else
          balance = nil
        end
      end
      return balance
    end
  end
