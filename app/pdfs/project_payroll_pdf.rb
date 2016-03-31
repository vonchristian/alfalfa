class ProjectPayrollPdf < Prawn::Document
   TABLE_WIDTHS = [150, 50, 80, 80, 80, 100]
def initialize(project, employees, view_context)
  super(margin: 30, page_size: [612, 1008], page_layout: :portrait)
  @project = project
  @employees = employees
  @view_context = view_context
  heading
  display_employees_table
end

def price(number)
  @view_context.number_to_currency(number, :unit => "P ")
end

def heading
  text "#{@project.name}", align: :center, size: 10
  move_down 5
  text "PAYROLL", align: :center
  move_down 5
  text "For the month of: #{Time.zone.now.strftime("%B %Y")}", align: :center, size: 10
end



  def display_employees_table
    if table_data.empty?
      text "No Employee data.", align: :center
    else
      table table_data,

        header: true,
        cell_style: { size: 8, font: "Helvetica"},
        column_widths: TABLE_WIDTHS
    end
  end
  def table_data
    move_down 5
     [["EMPLOYEE", "RATE", "DAYS WORKED", "CASH ADVANCES", "GROSS PAY", "RECEIVED BY"]] +
    @table_data ||= @employees.all.map { |e| [e.full_name.upcase, price(e.rate),  e.unpaid_worked_days_for(@project).to_s + " Days", e.unpaid_cash_advances, price(e.gross_pay(@project)), ""]}
  end



end
