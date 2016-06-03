class ContractorLineItemsPdf < Prawn::Document

  TABLE_WIDTHS = [80, 190, 55, 45, 85, 90]

  def initialize(contractor, view_context)
    super(margin: 30, page_size: [612, 948], page_layout: :portrait)
    @contractor = contractor
    @view_context = view_context
    heading
    summary
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
    text heading_date, align: :center, size: 11
    move_down 15
  end

  def heading_date

    if @contractor.orders.present?
      @contractor.orders.first.date_issued.strftime("%B %e, %Y") + " - " + @contractor.orders.last.date_issued.strftime("%B %e, %Y")
    else
    end
  end

  def summary_table
    [["Contractor: ", "#{(@contractor.name)}"]]
  end

  def summary
    table(summary_table, :cell_style => {size: 11, :padding => [2, 2, 2, 2]}) do
      cells.borders = []
    end
  end

  def display_issued_materials_table
    if @contractor.orders.blank?
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
    [["DATE", "INVENTORY", "QUANTITY", "UNIT", "UNIT COST", "TOTAL COST"]] +
    @table_data ||= @contractor.line_items.map{ |e| [e.order.date_issued.strftime('%B %e, %Y'), e.inventory.try(:name), e.quantity, e.inventory.unit, price(e.inventory.price), price(e.total_price)]} +
    [["", "", "", "", "<b>TOTAL</b>", "<b>#{price(@contractor.line_items.total_price)}</b>"]]
  end
end
