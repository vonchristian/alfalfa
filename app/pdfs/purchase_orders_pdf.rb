class PurchaseOrdersPdf < Prawn::Document
  TABLE_WIDTHS = [80, 190, 55, 45, 85, 90]
  def initialize(project, purchase_orders, view_context)
    super(margin: 20, page_size: [612, 1008], page_layout: :portrait)
    @project = project
    @purchase_orders = purchase_orders
    @view_context = view_context
    heading
    display_purchase_orders_table
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end


  def heading
    text "ALFALFA CONSTRUCTION", style: :bold, size: 10
    text "Ibulao, Baguinge, Kiangan, Ifugao", size: 10
    move_down 10

    text "PURCHASE ORDERS", style: :bold, size: 10
    move_down 2
    text "#{@project.name}", size: 8
    move_down 5
    stroke_horizontal_rule
  end
  def display_purchase_orders_table
    if @project.purchase_orders.blank?
      move_down 10
      text "No Purchase Orders.", align: :center
    else
      move_down 10
      table(purchase_orders_data, header: true, cell_style: { size: 9, font: "Helvetica", inline_format: true}, column_widths: TABLE_WIDTHS) do
        row(0).font_style = :bold
        row(0).background_color = 'DDDDDD'
        row(0).align = :center
      end
    end
  end

  def purchase_orders_data
    move_down 5
    [["DATE", "DESCRIPTION", "QUANTITY", "UNIT", "UNIT COST", "TOTAL COST"]] +
    @table_data ||= @purchase_orders.map{ |e| [e.date.strftime('%B %e, %Y'), e.description, e.quantity, e.unit, price(e.unit_cost), price(e.amount)]} +
    [["", "", "", "", "<b>TOTAL</b>", "<b>#{price(@purchase_orders.total_price)}</b>"]]

  end
end
