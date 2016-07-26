class ContractorLineItemsPdf < Prawn::Document

  TABLE_WIDTHS = [80, 190, 55, 45, 85, 90]

  def initialize(orders, customer_id, from_date, to_date, view_context)
    super(margin: 30, page_size: [612, 948], page_layout: :portrait)
    @orders = orders
    @from_date = from_date
    @to_date = to_date
    @customer_id = customer_id
    @customer = Contractor.find(@customer_id) if @customer_id.present?
    @view_context = view_context
    heading
    display_issued_materials_table
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def heading
    text "Issued Fuel to Contractor", align: :center
    move_down 5
    text "Alfalfa Construction", align: :center, size: 11
    move_down 5
    text heading_date, align: :center, size: 11
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
    if @customer_id.present?
      @customer.line_items.where("date" => @from_date..@to_date).sum(:total_cost)
    else
      Supplies::LineItem.where("date" => @from_date..@to_date).sum(:total_cost)
    end
  end

  def display_issued_materials_table
    if @orders.blank?
      move_down 10
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
    if @customer_id.blank?
      table_title = [["Name: ", "#{@customer.full_name}", "Total Orders:", "#{price(total_orders)}"]]
      table(table_title, :cell_style => {size: 9, :padding => [1, 1, 1, 1]}, column_widths: [80, 250, 150, 70]) do
        cells.borders = []
        column(1).font_style = :bold
        column(3).font_style = :bold
        column(2).align = :right
        column(3).align = :right
      end
      move_down 5
      [["DATE", "INVENTORY", "QUANTITY", "UNIT", "UNIT COST", "TOTAL COST"]] +
      @table_data ||= Supplies::LineItem.where(:date => @from_date..@to_date).order(date: :desc).map{ |e| [ e.date.strftime('%B %e, %Y'), e.inventory.try(:name), e.quantity, e.inventory.unit, price(e.inventory.price), price(e.total_cost)]} +
      [["", "", "", "", "<b>TOTAL</b>", "<b>#{price(total_orders)}</b>"]]
    else
      table_title = [["Name: ", "#{@customer}", "Total Orders:", "#{price(total_orders)}"]]
      table(table_title, :cell_style => {size: 9, :padding => [1, 1, 1, 1]}, column_widths: [80, 250, 150, 70]) do
        cells.borders = []
        column(1).font_style = :bold
        column(3).font_style = :bold
        column(2).align = :right
        column(3).align = :right
      end
      move_down 5
      [["DATE", "INVENTORY", "QUANTITY", "UNIT", "UNIT COST", "TOTAL COST"]] +
      @table_data ||= @customer.line_items.where(:date => @from_date..@to_date).order(date: :desc).map{ |e| [ e.order.date_issued.strftime('%B %e, %Y'), e.inventory.try(:name), e.quantity, e.inventory.unit, price(e.inventory.price), price(e.total_cost)]} +
      [["", "", "", "", "<b>TOTAL</b>", "<b>#{price(total_orders)}</b>"]]
    end
  end
end
