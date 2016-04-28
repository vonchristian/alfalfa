class IssuedInventoryPdf < Prawn::Document

  TABLE_WIDTHS = [210, 70, 70, 100, 100]

  def initialize(issued_inventories, project, from_date, to_date, view_context)
    super(margin: 30, page_size: [612, 948], page_layout: :portrait)
    @issued_inventories = issued_inventories
    @project = project
    @from_date = from_date
    @to_date = to_date
    @view_context = view_context
    heading
    summary if @project.present?
    display_issued_materials_table
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def heading
    text "Issued Materials Summary", align: :center
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

  def summary_table
    [["Project: ", "#{(@project.name)}"]]
  end

  def summary
    table(summary_table, :cell_style => {size: 11, :padding => [2, 2, 2, 2]}) do
      cells.borders = []
    end
  end

  def display_issued_materials_table
    if issued_materials_data.empty?
      text "No Issued Materials.", align: :center
    else
      move_down 10
      table(issued_materials_data, header: true, cell_style: { size: 9, font: "Helvetica", inline_format: true}, column_widths: TABLE_WIDTHS) do
        row(0).font_style = :bold
        row(0).background_color = 'DDDDDD'
        row(0).align = :center
      end
    end
  end

  def issued_materials_data
    move_down 5
    [["INVENTORY", "QUANTITY", "UNIT", "UNIT COST", "TOTAL COST"]] +
    @table_data ||= @issued_inventories.entered_on({from_date: @from_date, to_date: @to_date, :project_id => @project}).map { |e| [e.inventory.name, e.quantity, e.inventory.unit, (price e.unit_cost), (price e.total_cost)]} +
    @table_data ||= [["", "", "", "TOTAL", "#{(price @issued_inventories.entered_on({from_date: @from_date, to_date: @to_date}).sum(:total_cost))}"]]
  end
end
