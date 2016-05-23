class ContractSummaryReportPdf < Prawn::Document
  TABLE_WIDTHS = [40, 200]
def initialize(projects, view_context)
  super(margin: 30, page_size: [612, 1008], page_layout: :landscape)
  @projects = projects
  @view_context = view_context
  heading
  display_projects_table

end
def price(number)
  @view_context.number_to_currency(number, :unit => "P ")
end
def heading
  text "Contract Summary Report "
end
def display_projects_table
    if project_data.empty?
      text "No Fund Transfer data.", align: :center
    else
      move_down 10
      table(project_data, header: true, cell_style: { size: 8, font: "Helvetica"}, column_widths: TABLE_WIDTHS) do
        cells.borders = []
        row(0).font_style = :bold
        row(0).background_color = 'DDDDDD'
      end
    end
  end

  def project_data
    move_down 5
    [["ID", "PROJECT NAME", "APPROVED CONTRACT", "APPROVED CHANGE ORDERS", "REVISED CONTRACT", "PAYMENT RECEIVED", "REMAINING", "PERCENT COMPLETED","NTP", "EXPIRY DATE"]] +
    @fund_transfer_data ||= @projects.map { |e| [e.id_number, e.name, price(e.cost), price(e.total_amount_revision), price(e.revised_contract_amount), "", "", e.actual_accomplishment.round(2), "#{e.start_date}", e.expiry_date]}
  end
end
