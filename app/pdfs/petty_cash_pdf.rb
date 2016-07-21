class PettyCashPdf < Prawn::Document

  TABLE_WIDTHS = [150, 200, 100, 100]

  def initialize(petty_cash, from_date, to_date, view_context)
    super(margin: 30, page_size: [612, 948], page_layout: :portrait)
    @petty_cash = petty_cash
    @from_date = from_date
    @to_date = to_date
    @view_context = view_context
    heading
    summary
    display_fund_transfer_table
    display_petty_cash_table
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def heading
    text "Petty Cash Summary", align: :center
    move_down 5
    text "Alfalfa Construction", align: :center, size: 11
    move_down 5
    text set_date, align: :center, size: 11
    move_down 15
  end

  def set_date
    if (@to_date.strftime("%B %e, %Y") == @from_date.strftime("%B %e, %Y"))
      @to_date.strftime("%B %e, %Y")
    else
      @from_date.strftime("%B %e, %Y") + " - " + @to_date.strftime("%B %e, %Y")
    end
  end

  def oldest?
    if Accounting::Entry.any?
      @from_date < Accounting::Entry.first.date
    end
  end

  def previous_debit_balance
    if Accounting::Entry.any?
      Account.find_by_name("Petty Cash").debits_balance({from_date: Accounting::Entry.first.date, to_date: @from_date})
    end
  end

  def previous_credit_balance
    if Accounting::Entry.any?
      Account.find_by_name("Petty Cash").credits_balance({from_date: Accounting::Entry.first.date, to_date: @from_date})
    end
  end

  def current_debit_balance
    Account.find_by_name("Petty Cash").debits_balance({from_date: @from_date, to_date: @to_date})
  end

  def current_credit_balance
    Account.find_by_name("Petty Cash").credits_balance({from_date: @from_date, to_date: @to_date})
  end

  def starting_balance
    previous_debit_balance - previous_credit_balance if previous_debit_balance.present?
  end

  def outstanding_balance
    if previous_debit_balance.present? && previous_credit_balance.present? && current_debit_balance.present? && current_credit_balance.present?
      "#{(price starting_balance + current_debit_balance - current_credit_balance)}"

    elsif previous_debit_balance.blank? && previous_credit_balance.blank? && current_debit_balance.present? && current_credit_balance.present?
      "#{(price current_debit_balance - current_credit_balance)}"
    end
  end

  def data_summary
      [["Starting Balance:", "#{(price starting_balance)}"],
        ["Fund Transfer:", "#{(price Account.find_by_name("Petty Cash").debits_balance({from_date: @from_date, to_date: @to_date}))}"],
        ["Disbursed:", "#{(price Account.find_by_name("Petty Cash").credits_balance({from_date: @from_date, to_date: @to_date}))}"],
        ["Outstanding Balance:", outstanding_balance]]
  end

  def summary
    table(data_summary, :cell_style => {size: 11, :padding => [2, 2, 2, 2]}) do
      cells.borders = []
    end
  end

  def display_fund_transfer_table
    if Accounting::Entry.blank?
      move_down 10
      text "No Fund Transfer data.", align: :center
    else
      move_down 15
      text "CASH IN", size: 10
      table(fund_transfer_data, header: true, cell_style: { size: 8, font: "Helvetica"}, column_widths: TABLE_WIDTHS) do
        row(0).font_style = :bold
        row(0).background_color = 'DDDDDD'
      end
    end
  end

  def fund_transfer_data
    move_down 5
    [["SOURCE ACCOUNT", "DESCRIPTION", "DATE", "AMOUNT"]] +
    @fund_transfer_data ||= Account.find_by_name("Petty Cash").debit_entries.entered_on({from_date: @from_date, to_date: @to_date}).order(:date).reverse.map { |e| [e.credit_amounts.last.account.name, e.description, e.date.strftime("%B %e, %Y"), (price e.credit_amounts.last.amount)]} +
    @fund_transfer_data ||= [["", "", "TOTAL", "#{(price Account.find_by_name("Petty Cash").debits_balance({from_date: @from_date, to_date: @to_date}))}"]]
  end

  def display_petty_cash_table
    if Accounting::Entry.blank?
      move_down 10
      text "No Transaction data.", align: :center
    else
      move_down 10
      text "CASH OUT", size: 10
      table(table_data, header: true, cell_style: { size: 8, font: "Helvetica"}, column_widths: TABLE_WIDTHS) do
        row(0).font_style = :bold
        row(0).background_color = 'DDDDDD'
      end
    end
  end

  def table_data
    move_down 5
    [["RECIPIENT", "DESCRIPTION", "DATE", "AMOUNT"]] +
    @table_data ||= Account.find_by_name("Petty Cash").credit_entries.entered_on({from_date: @from_date, to_date: @to_date}).order(:date).reverse.map { |e| [e.entriable.try(:name), e.description, e.date.strftime("%B %e, %Y"), (price e.credit_amounts.last.amount)]} +
    @table_data ||= [["", "", "TOTAL", "#{(price Account.find_by_name("Petty Cash").credits_balance({from_date: @from_date, to_date: @to_date}))}"]]
  end
end
