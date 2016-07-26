class OrderLineItemsPdf < Prawn::Document

  TABLE_WIDTHS = [240, 60, 50, 100, 100]

  def initialize(orders, customer_id, from_date, to_date, view_context)
    super(margin: 30, page_size: [612, 948], page_layout: :portrait)
    @orders = orders
    @from_date = from_date
    @to_date = to_date
    @customer_id = customer_id
    @customers = Project.all + Contractor.all + Equipment.all
    @view_context = view_context
    heading
    ordered_items_data
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def heading
    text "Issued Fuel Summary", align: :center
    move_down 5
    text "Alfalfa Construction", align: :center, size: 11
    move_down 5
    text heading_date, align: :center, size: 11
    move_down 15
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
    Supplies::LineItem.where("date" => @from_date..@to_date).sum(:total_cost)
  end

  def ordered_items_data
    move_down 10
    if Supplies::Order.filter_with(from_date: @from_date, to_date: @to_date).any?
      table_title = [["", "", "Total Orders:", "#{price(total_orders)}"]]
      table(table_title, :cell_style => {size: 9, :padding => [1, 1, 1, 1]}, column_widths: [80, 250, 150, 70]) do
        cells.borders = []
        column(1).font_style = :bold
        column(3).font_style = :bold
        column(2).align = :right
        column(3).align = :right
      end
      move_down 10
      stroke_horizontal_rule
      move_down 10
      Supplies::Order.filter_with(from_date: @from_date, to_date: @to_date).order('date_issued DESC').each do |order|
        table_subtitle = [["Customer: ", "#{order.customer}", "Order Date:", "#{order.date_issued.strftime('%B %e, %Y')}"]]
        table(table_subtitle, :cell_style => {size: 9, :padding => [1, 1, 1, 1]}, column_widths: [80, 250, 150, 70]) do
          cells.borders = []
          column(1).font_style = :bold
          column(3).font_style = :bold
          column(2).align = :right
          column(3).align = :right
        end
        move_down 2
        header = ["Item Name", "Unit", "Quantity", "Unit Price", "Total Price"]
        footer = ["", "", "", "<b>TOTAL</b>", "<b>#{price(order.line_items.total_price)}</b>"]
        line_items_data = order.line_items.map { |e| [ e.inventory.try(:name), e.inventory.unit, e.quantity, price(e.unit_cost), price(e.total_cost) ]}

        table_data = [header, *line_items_data, footer]
        table(table_data, cell_style: { size: 9, font: "Helvetica", inline_format: true}, column_widths: TABLE_WIDTHS) do
          row(0).font_style = :bold
          row(0).background_color = 'DDDDDD'
          row(0).align = :center
        end
        move_down 20
      end
      move_down 25
    else
      text "No Orders during this dates.", align: :center
    end
  end
end
