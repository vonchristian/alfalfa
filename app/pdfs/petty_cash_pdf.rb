class PettyCashPdf < Prawn::Document
   TABLE_WIDTHS = [150, 200, 100, 100]
def initialize(petty_cash, view_context)
  super(margin: 30, page_size: [612, 1008], page_layout: :portrait)
  @petty_cash = petty_cash
  @view_context = view_context
  heading
  summary
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
  text "For the month of: #{Time.zone.now.strftime("%B %Y")}", align: :center, size: 10
end

def summary
  text "Beginning Balance", size: 10
  text "Fund Transfers", size: 10
  text "Disbursed", size: 10
  text "Outstanding Balance", size: 10
end


  def display_petty_cash_table
    if table_data.empty?
      text "No Employee data.", align: :center
    else
      table table_data,

        header: true,
        cell_style: { size: 8, font: "Helvetica"},
        column_widths: TABLE_WIDTHS
    end
  end
  def table_data
    move_down 5
     [["RECIPIENT", "DESCRIPTION", "DATE", "AMOUNT"]] +
    @table_data ||= @petty_cash.credit_entries.map { |e| [e.recipient.try(:name), e.description, e.date.strftime("%B %e, %Y"), price(e.credit_amounts.last.amount)]} +
    @table_data ||= [["TOTAL", "", "", "," "#{price(@petty_cash.credits_balance)}"]]
  end



end
