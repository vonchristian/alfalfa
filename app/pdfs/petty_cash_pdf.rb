class PettyCashPdf < Prawn::Document

  TABLE_WIDTHS = [150, 200, 100, 100]
  
  def initialize(petty_cash, from_date, to_date, view_context)
    super(margin: 30, page_size: [612, 1008], page_layout: :portrait)
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
    text "Alfalfa Construction", align: :center, size: 10
    move_down 5
    text "#{@from_date.strftime("%B %e, %Y")} - #{@to_date.strftime("%B %e, %Y")}", align: :center, size: 10
    move_down 15
  end

  def data_summary 
    [["Beginning Balance:", "#{(price @petty_cash.balance({from_date: @petty_cash.created_at, to_date: @from_date }))}"],
      ["Fund Transfers:", "#{(price @petty_cash.debits_balance({from_date: @from_date, to_date: @to_date}))}"],
      ["Disbursed:", "#{(price @petty_cash.credits_balance({from_date: @from_date, to_date: @to_date}))}"],
      ["Outstanding Balance:", "#{(price @petty_cash.balance({from_date: @petty_cash.created_at, to_date: @to_date}))}"]]

  end

  def summary
    table(data_summary, :cell_style => {size: 10, :padding => [2, 2, 2, 2]}) do
      cells.borders = []
    end
  end

  def display_fund_transfer_table
    if fund_transfer_data.empty?
      text "No Fund Transfer data.", align: :center
    else
      move_down 10
      text "FUND TRANSFER TRANSACTION", size: 10
      table(fund_transfer_data, header: true, cell_style: { size: 8, font: "Helvetica"}, column_widths: TABLE_WIDTHS) do
        row(0).font_style = :bold
        row(0).background_color = 'DDDDDD'
      end
    end
  end

  def fund_transfer_data
    move_down 5
    [["SOURCE ACCOUNT", "DESCRIPTION", "DATE", "AMOUNT"]] +
    @fund_transfer_data ||= @petty_cash.debit_entries.entered_on({from_date: @from_date, to_date: @to_date}).map { |e| [e.credit_amounts.last.account.name, e.description, e.date.strftime("%B %e, %Y"), (price e.credit_amounts.last.amount)]} +
    @fund_transfer_data ||= [["", "", "TOTAL", "#{(price @petty_cash.debits_balance({from_date: @from_date, to_date: @to_date}))}"]]
  end
  
  def display_petty_cash_table
    if table_data.empty?
      text "No Employee data.", align: :center
    else
      move_down 10
      text "DISBURSEMENT TRANSACTION", size: 10
      table(table_data, header: true, cell_style: { size: 8, font: "Helvetica"}, column_widths: TABLE_WIDTHS) do
        row(0).font_style = :bold
        row(0).background_color = 'DDDDDD'
      end
    end
  end
  
  def table_data
    move_down 5
    [["RECIPIENT", "DESCRIPTION", "DATE", "AMOUNT"]] +
    @table_data ||= @petty_cash.credit_entries.entered_on({from_date: @from_date, to_date: @to_date}).map { |e| [e.recipient.try(:name), e.description, e.date.strftime("%B %e, %Y"), (price e.credit_amounts.last.amount)]} +
    @table_data ||= [["", "", "TOTAL", "#{(price @petty_cash.credits_balance({from_date: @from_date, to_date: @to_date}))}"]]
  end
end
