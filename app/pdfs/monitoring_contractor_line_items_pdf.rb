class MonitoringContractorLineItemsPdf < Prawn::Document

  class ContractorLineItemsPdf < Prawn::Document

  TABLE_WIDTHS = [90, 190, 55, 50, 75, 90]

  def initialize(contractor, line_items, view_context)
    super(margin: 30, page_size: [612, 948], page_layout: :portrait)
    @line_items  = line_items
    @contractor = contractor
    @view_context = view_context
    heading
    ordered_items
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def heading
    text "Issued Inventories to Contractor", align: :center, size: 11
    move_down 2
    text "Alfalfa Construction", align: :center, size: 11
    move_down 2
    text heading_date, align: :center, size: 10
    move_down 10
  end

  def heading_date
    if @from_date.strftime("%B %Y") == @to_date.strftime("%B %Y") && @from_date.strftime("%e") != @to_date.strftime("%e")
      @from_date.strftime("%B %e") + " - " + @to_date.strftime("%e, %Y")
    elsif @from_date.strftime("%B %e %Y") == @to_date.strftime("%B %e %Y")
      @to_date.strftime("%B %e, %Y")
    elsif @from_date.strftime("%B") != @to_date.strftime("%B") || @from_date.strftime("%Y") != @to_date.strftime("%Y")
      @from_date.strftime("%B %e, %Y") + " - " + @to_date.strftime("%B %e, %Y")
    end
  end

  def total_orders
    @contractor.line_items.sum(:total_cost)
  end

  def ordered_items
    move_down 10
    if @contractor.line_items.blank?
      text "No Orders for", align: :center
    else
      table_title = [["Contractor Name: ", "#{@contractor.try(:name)}", "Total Amount: ", "#{price(total_orders)}"]]
      table(table_title, :cell_style => {size: 9, :padding => [1, 1, 1, 1]}, column_widths: [80, 250, 150, 70]) do
        cells.borders = []
        column(1).font_style = :bold
        column(3).font_style = :bold
        column(2).align = :right
        column(3).align = :right
      end
      move_down 4
      table(table_data, position: :right, header: true,
      cell_style: { size: 7, font: "Helvetica", :padding => [1, 2, 2, 2]},
      column_widths: TABLE_WIDTHS) do
        row(0).font_style = :bold
        row(0).background_color = 'DDDDDD'
        row(0).align = :center
      end
    end
  end

  def table_data
    if @contractor.line_items.present?
      [["Date", "Item", "Unit", "Quantity", "Unit Cost", "Total Cost"]] +
      @table_data ||= @contractor.line_items.map { |e| [ e.date.strftime("%B %e, %Y"), e.inventory.try(:name), e.inventory.unit, e.quantity, price(e.inventory.price), price(e.total_cost) ] } +
      @table_data ||= [["", "", "", "", "TOTAL", "#{price(total_orders)}"]]
    else
      [["Date", "Item", "Unit", "Quantity", "Unit Cost", "Total Cost"]] +
      [["", "No Orders for #{inventory_name}.", "", "", "", ""]]
    end
  end
end

end
