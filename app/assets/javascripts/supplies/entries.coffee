jQuery ->
  output = $('#accounting_entry_credit_amounts_attributes_0_amount')
  $('#accounting_entry_debit_amounts_attributes_0_amount').keyup (event) ->
    output.val(this.value)

jQuery ->
  output = $('#transactions_contractor_invoice_payment_credit_amounts_attributes_0_amount')
  $('#transactions_contractor_invoice_payment_debit_amounts_attributes_0_amount').keyup (event) ->
    output.val(this.value)

jQuery ->
  output = $('#transactions_cash_advance_credit_amounts_attributes_0_amount')
  $('#transactions_cash_advance_debit_amounts_attributes_0_amount').keyup (event) ->
    output.val(this.value)

jQuery ->
  output = $('#transactions_invoice_payment_credit_amounts_attributes_0_amount')
  $('#transactions_invoice_payment_debit_amounts_attributes_0_amount').keyup (event) ->
    output.val(this.value)
