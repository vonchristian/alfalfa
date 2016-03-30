class IssuedInventoryPdf < Prawn::Document

  TABLE_WIDTHS = [130, 180, 50, 50, 70, 70]
  
  def initialize(issued_inventories, from_date, to_date, view_context)
    super(margin: 30, page_size: [612, 948], page_layout: :portrait)
    @issued_inventories = issued_inventories
    @from_date = from_date
    @to_date = to_date
    @view_context = view_context
    heading
    summary
    display_petty_cash_table
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def heading
    text "Issued Materials Summary", align: :center
    move_down 5
    text "Alfalfa Construction", align: :center, size: 11
    move_down 5
    text "#{@from_date.strftime("%B %e, %Y")} - #{@to_date.strftime("%B %e, %Y")}", align: :center, size: 11
    move_down 15
  end

  def data_summary
    [["Total Amount:", "#{(price @issued_inventories.entered_on({from_date: @from_date, to_date: @to_date}).sum(:total_cost))}"]]
  end

  def summary
    table(data_summary, :cell_style => {size: 11, :padding => [2, 2, 2, 2]}) do
      cells.borders = []
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
    @table_data ||= @issued_inventories.entered_on({from_date: @from_date, to_date: @to_date}).map { |e| [e.inventoriable_id, e.inventory.name, e.quantity, e.inventory.unit, (price e.inventory.cost), (price e.total_cost)]} +
    @table_data ||= [["", "", "", "", "TOTAL", "#{(price @issued_inventories.entered_on({from_date: @from_date, to_date: @to_date}).sum(:total_cost))}"]]
  end
end
