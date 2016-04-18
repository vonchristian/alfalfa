class SalesPdf < Prawn::Document

  TABLE_WIDTHS = [130, 180, 50, 50, 70, 70]
  
  def initialize(sales, from_date, to_date, view_context)
    super(margin: 30, page_size: [612, 948], page_layout: :portrait)
    @sales = sales
    @from_date = from_date
    @to_date = to_date
    @view_context = view_context
    heading
    display_petty_cash_table
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def heading
    text "Sales Summary", align: :center
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
  
  def display_petty_cash_table
    if table_data.empty?
      text "No Issued Materials.", align: :center
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
    [["RECIPIENT", "INVENTORY NAME", "QUANTITY", "UNIT", "UNIT COST", "TOTAL COST"]] +
    @table_data ||= @sales.entered_on({from_date: @from_date, to_date: @to_date}).map { |e| [e.try(:recipient), e.inventory.name, e.quantity, e.inventory.unit, (price e.inventory.restockings.last.try(:price)), (price e.amount)]} +
    @table_data ||= [["", "", "", "", "TOTAL", "#{(price @sales.entered_on({from_date: @from_date, to_date: @to_date}).sum(:amount))}"]]
  end
end
