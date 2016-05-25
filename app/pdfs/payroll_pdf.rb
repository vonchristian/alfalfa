class PayrollPdf < Prawn::Document

def initialize(employees, view_context)
  super( page_size: [612, 1008], page_layout: :landscape)
  @employees = employees
  heading
  display_payroll
end

def price(number)
  @view_context.number_to_currency(number, :unit => "P ")
end


def heading
  text "ALFALFA CONSTRUCTION", style: :bold, size: 10
  text "Ibulao, Baguinge, Kiangan, Ifugao", size: 10
  move_down 10

  text "PAYROLL SUMMARY REPORT", style: :bold, size: 10
  move_down 5
  stroke_horizontal_rule
  end

  def display_payroll
    move_down 10
      table(payroll_data, header: false,  cell_style: { size: 10, font: "Helvetica", :inline_format => true}, column_widths: [200, 100, 100, 80, 80, 80, 80, 150]) do
    
    end
  end

  def payroll_data
    move_down 5
    [["<b>Employee</b>", "<b>Position</b>", "<b>Rate</b>", "<b># Days Worked</b>", "<b>Overtime (Hours) </b>", "<b>Cash Advances</b>", "<b>Earned Income</b>", "<b>Gross Pay</b>"]] + 
    @payroll_data ||= @employees.map { |e| [e.full_name, e.position.titleize, e.rate, e.unpaid_worked_days, e.unpaid_overtimes, e.unpaid_cash_advances, e.earned_income, e.total_gross_pay ]}
  end
end
