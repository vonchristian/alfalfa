class StatementOfWorkAccomplishedPdf < Prawn::Document
  TABLE_WIDTHS = [40, 200, 30, 55, 60, 80, 60, 60, 60, 60, 60, 60,60]
def initialize(project, view_context)
  super(margin: 30, page_size: [612, 1008], page_layout: :landscape)
  @project = project
  @view_context = view_context
  heading
  project_info
  display_work_details_table
end
def price(number)
  @view_context.number_to_currency(number, :unit => "P ")
end

def heading
  text "CONTRACTOR'S STATEMENT OF WORK ACCOMPLISHED", align: :center
  move_down 5
  text "From: #{Time.zone.now.strftime("%B %e, %Y")} To: #{Time.zone.now.next_month.strftime("%B %e, %Y")}", align: :center, size: 10
end

def project_info
  move_down 50
  text "NAME OF PROJECT: <u>#{@project.name.upcase}</u>", inline_format: true, size: 10
  move_down 3
  text "LOCATION:                 #{@project.address}", size: 10
  move_down 3
  text "CONTRACTOR:", size: 10
  move_down 3
  text "PROJECT DURATION: #{@project.duration} Days", size: 10
  end

  def display_work_details_table
    if table_data.empty?
      text "No work detail ACCOMPLISHED.", align: :center
    else
      table table_data,

        header: true,
        cell_style: { size: 7, font: "Helvetica"},
        column_widths: TABLE_WIDTHS
    end
  end
  def table_data
    move_down 5
     [["ITEM", "DESCRIPTION", "UNIT", "TOTAL CONTRACT QUANTITY", "UNIT PRICE", "TOTAL CONTRACT COST", "Wt. %", "TOTAL QTY. APPROVED IN PREVIOUS BILLING",
      "TOTAL QUANTITY APPROVED IN THIS BILLING", "BALANCE OF QUANTITY", "COST OF PREVIOUS BILLINGS", "COST OF THIS BILLING", "COST TO DATE", "BALANCE OF COST"]] +
    @table_data ||= @project.work_details.map { |e| [e.code,
                                                                                      e.description,
                                                                                      e.unit, e.quantity,
                                                                                      price(e.unit_cost),
                                                                                      price(e.total_cost),
                                                                                       "#{e.weighted_percent.round(3)} %",
                                                                                      price(e.total_quantity_approved_in_previous_billing),
                                                                                      price(e.total_quantity_approved_in_this_billing),
                                                                                      e.balance_of_quantity,
                                                                                      price(e.cost_of_previous_billings),
                                                                                      price(e.cost_of_this_billing),
                                                                                      price(e.cost_to_date),
                                                                                      price(e.balance_of_cost)
                                                                                        ] } +
        @table_data ||= [["TOTAL", "", "", "", "", "#{price(@project.cost)}", "", "", "", "", "", ""]]
  end



end
