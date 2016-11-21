class OrderLineItemsPdf < Prawn::Document

  TABLE_WIDTHS = [80, 350, 200, 45, 50, 80, 80]

  def initialize(line_items, inventory_id, from_date, to_date, view_context)
    super(margin: 30, page_size: [612, 948], page_layout: :landscape)
    @from_date = from_date
    @to_date = to_date
    @line_items = line_items
    @inventory_id = inventory_id
    @view_context = view_context
    heading
    ordered_items
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def heading
    text header_title, align: :center
    move_down 5
    text "Alfalfa Construction", align: :center, size: 11
    move_down 5
    text heading_date, align: :center, size: 11
    move_down 15
  end

  def header_title
    if @inventory_id.present? 
      "Issued #{Supplies::Inventory.find(@inventory_id).item_category || Supplies::Inventory.find(@inventory_id).name}"
    else
      "Issued Inventories"
    end
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
    if @inventory_id.present?
      @line_items.where(:inventory_id => @inventory_id).sum(:total_cost)
    else
      @line_items.sum(:total_cost)
    end
  end

  def ordered_items
    move_down 10
    if @line_items.blank?
      text "No Orders during this dates.", align: :center
    else
      text "Total Amount: #{price(total_orders)}", align: :right, size: 11
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
    if @inventory_id.present?
      [["Date", "Issued To", "Item", "Unit", "Quantity", "Unit Cost", "Total Cost"]] +
      @table_data ||= @line_items.where(:inventory_id => @inventory_id).all.map { |e| [ e.date.strftime("%B %e, %Y"), "#{e.order.try(:customer, :name)}", e.inventory.try(:name), e.inventory.unit, e.quantity, price(e.unit_cost), price(e.total_cost) ] } +
      @table_data ||= [["", "", "", "", "", "TOTAL", "#{price(total_orders)}"]]
    else
      [["Date", "Issued To", "Item", "Unit", "Quantity", "Unit Cost", "Total Cost"]] +
      @table_data ||= @line_items.map { |e| [ e.date.strftime("%B %e, %Y"), "#{e.order.try(:customer, :name) }", e.inventory.try(:name), e.inventory.unit, e.quantity, price(e.unit_cost), price(e.total_cost) ] } +
      @table_data ||= [["", "", "", "", "", "TOTAL", "#{price(total_orders)}"]]
    end
  end
end
