class PayrollPdf < Prawn::Document

def initialize(employees, view_context)
  super( page_size: [612, 1008], page_layout: :landscape)
  @employees = employees
  @view_context = view_context
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
      table(payroll_data, header: false,  cell_style: { size: 10, font: "Helvetica", :inline_format => true}, column_widths: [200, 80, 50, 80, 80, 100, 100, 150]) do
    
    end
  end

  def payroll_data
    move_down 5
    [["<b>Employee</b>", "<b>Position</b>", "<b>Rate</b>", "<b># Days Worked</b>", "<b>Overtime (Hours) </b>", "<b>Cash Advances</b>", "<b>Earned Income</b>", "<b>Gross Pay</b>"]] + 
    @payroll_data ||= @employees.map { |e| [e.full_name, e.position.titleize, e.rate, e.unpaid_worked_days, e.unpaid_overtimes, price(e.unpaid_cash_advances), price(e.earned_income), price(e.total_gross_pay) ]} +
    [["", "", "", "", "", "<b>#{price(@employees.total_cash_advances)}</b>", "<b>#{price(@employees.total_earned_income)}</b>", "<b>#{price(@employees.total_gross_pay)}</b>"]]
  end
end
