class StatementOfWorkAccomplishedPdf < Prawn::Document
  TABLE_WIDTHS = [40, 160, 30, 55, 60, 65, 40, 60, 60, 60, 60, 60, 60, 65]

  def initialize(project, view_context)
    super(margin: 30, page_size: [612, 936], page_layout: :landscape)
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
    text "CONTRACTOR'S STATEMENT OF WORK ACCOMPLISHED", align: :center, size: 10
    move_down 5
    if @project.work_accomplishments.any?
      text "From: #{@project.work_accomplishments.first.date_accomplished.strftime("%B %e, %Y")} To: #{@project.work_accomplishments.last.date_accomplished.strftime("%B %e, %Y")}", align: :center, size: 10
    end
  end

  def project_info_table
    move_down 5
    [["NAME OF PROJECT:", "#{@project.name.upcase}"],
      ["LOCATION:", "#{@project.address.upcase}"],
      ["PROJECT DURATION:", "#{@project.duration} DAYS"],
      ["CONTRACTOR:", "#{@project.main_contractor.company.upcase if @project.main_contractor.present?}"]]
  end

  def project_info
    table(project_info_table, :cell_style => {size: 9, :padding => [1, 2, 2, 2]}, column_widths: [150, 700]) do
      cells.borders = []
    end
  end

  def display_work_details_table
    if table_data.empty?
      text "No work detail ACCOMPLISHED.", align: :center
    else
      table(table_data, position: :right,
        header: true,
        cell_style: { size: 7, font: "Helvetica", :padding => [1, 2, 2, 2]},
        column_widths: TABLE_WIDTHS) do
          row(0).font_style = :bold
          row(0).font_size = 6
          row(0).background_color = 'DDDDDD'
        end
    end
  end
  def table_data
    move_down 5
     [["ITEM", "DESCRIPTION", "UNIT", "TOTAL CONTRACT QUANTITY", "UNIT PRICE", "TOTAL CONTRACT COST", "Wt. %", "TOTAL QTY. APPROVED IN PREVIOUS BILLING",
      "TOTAL QUANTITY APPROVED IN THIS BILLING", "BALANCE OF QUANTITY", "COST OF PREVIOUS BILLINGS", "COST OF THIS BILLING", "COST TO DATE", "BALANCE OF COST"]] +
    @table_data ||= @project.work_details.map { |e| [e.code,
                                                    e.description.upcase,
                                                    e.unit, e.quantity,
                                                    price(e.unit_cost),
                                                    price(e.total_cost),
                                                    "#{e.weighted_percent.round(3)} %",
                                                    e.total_quantity_approved_in_previous_billing,
                                                    e.total_quantity_approved_in_this_billing,
                                                    e.balance_of_quantity,
                                                    price(e.cost_of_previous_billings),
                                                    price(e.cost_of_this_billing),
                                                    price(e.cost_to_date),
                                                    price(e.balance_of_cost)
                                                      ] } +
        @table_data ||= [["TOTAL", "", "", "", "", "#{price(@project.cost)}", "", "", "", "", "", "", "", ""]]
  end



end
