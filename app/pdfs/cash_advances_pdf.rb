class CashAdvancesPdf < Prawn::Document
 TABLE_WIDTHS = [300, 250]
def initialize(entries, from_date, to_date, view_context)
  super(margin: 20, page_size: [612, 1008], page_layout: :portrait)
  @entries = entries
  @from_date = from_date
  @to_date = to_date
  @view_context = view_context
  heading

  display_entries_table
end

def price(number)
  @view_context.number_to_currency(number, :unit => "P ")
end


def heading
  text "ALFALFA CONSTRUCTION", style: :bold, size: 10, align: :center
  text "Kiangan, Ifugao", size: 10, align: :center
  move_down 15

  text "Cash Advances from #{@from_date.strftime("%B  %e, %Y")} TO #{@to_date.strftime("%B %e, %Y")}", style: :bold, size: 10, align: :center
  move_down 5
  stroke_horizontal_rule
  end
  def display_entries_table
    if Transactions::CashAdvance.blank?
      move_down 10
      text "No Transaction data.", align: :center
    else
      move_down 10

      table(table_data, header: true, cell_style: { size: 8, font: "Helvetica"}, column_widths: TABLE_WIDTHS) do
        row(0).font_style = :bold
        row(0).background_color = 'DDDDDD'
      end
    end
  end

  def table_data
    move_down 5
    [["EMPLOYEE", "AMOUNT"]] +
    @table_data ||= Employee.all.order(:last_name).map {|e| [e.full_name, price(e.unpaid_cash_advances)]} +
    @table_data ||= [["TOTAL", "#{(price Account.find_by_name("Advances to Employees").balance({from_date: @from_date, to_date: @to_date}))}"]]
  end
end
