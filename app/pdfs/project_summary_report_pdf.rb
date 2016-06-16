require 'prawn/icon'
class ProjectSummaryReportPdf < Prawn::Document
  def initialize(project, view_context)
    super(margin: 40)
    @project = project
    @view_context = view_context
    heading
    summary
    costs
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def heading

    text "PROJECT SUMMARY REPORT", size: 8, style: :bold
    move_down 10
    text "<b>##{@project.id_number}</b> - #{@project.name}", size: 10, inline_format: true
    move_down 5
    y_position = cursor - 3
    bounding_box([0, y_position], :width => 20, :height => 10) do
    transparent(0) { stroke_bounds }
    icon 'fa-map-marker', size: 6, color: '4A4A4A'
  end
  bounding_box([10, y_position], :width => 150, :height => 10) do
  transparent(0) { stroke_bounds }
  text "#{@project.address.upcase}", size: 8, color: '4A4A4A'
end
if @project.main_contractor.present?
bounding_box([90, y_position], :width => 20, :height => 10) do
transparent(0) { stroke_bounds }
icon 'fa-bookmark', size: 6, color: '4A4A4A'
end
bounding_box([100, y_position], :width => 300, :height => 10) do
transparent(0) { stroke_bounds }
text "#{@project.main_contractor.company.upcase}", size: 8, color: '4A4A4A'
end
  end
end
  def summary
y_position = cursor - 20
bounding_box([0, y_position], :width => 280, :height => 150) do
transparent(0) { stroke_bounds }
text "PROJECT INFO", style: :bold, size: 10, color: '4A4A4A'
move_down 5
text "Notice to Proceed              #{@project.ntp}", size: 10
move_down 5
text "Contract Amount                #{price(@project.revised_contract_amount)}", size: 10
move_down 5
text "Project Duration                 #{@project.latest_duration} Days", size: 10
move_down 5
text "Days Elapsed                     #{@project.days_elapsed} Days", size: 10
move_down 5
text "Days Remaining                #{@project.remaining_days} Days", size: 10

move_down 5
text "Implementing Office          #{@project.implementing_office}", size: 10
end
bounding_box([300, y_position], :width => 200, :height => 150) do
transparent(0) { stroke_bounds } # This will stroke on one page
text "PROJECT STATUS",  style: :bold, size: 10, color: '4A4A4A'
text "(As of #{Time.zone.now.strftime("%B %e, %Y")})", size: 8, color: "3E3E3E"
move_down 5
text "Target Accomplishment            #{@project.target_accomplishment.round(2)} %", size: 10, color: "4A4A4A"
move_down 5
text "Actual Accomplishment            #{@project.actual_accomplishment.round(2)} %", size: 10, color: "5FCF80"
move_down 5

text "SLIPPAGE                                #{@project.slippage.round(2)} %", size: 10, color: "CC181E"
end
stroke_horizontal_rule
end
def costs
y_position = cursor - 20
bounding_box([0, y_position], :width => 250, :height => 150) do
transparent(0) { stroke_bounds }
text "DIRECT COSTS", style: :bold, size: 10, color: '4A4A4A'
text "(As of #{Time.zone.now.strftime("%B %e, %Y")})", size: 8, color: "3E3E3E"
move_down 5
text "Materials                                          #{price(@project.direct_material_costs)}", size: 10
move_down 5
text "Labor                                               #{price(@project.labor_costs.total)}", size: 10
move_down 5
text "Equipment                                       #{price(@project.equipment_costs.total)}", size: 10
move_down 5
text "SubContract                                    #{price(@project.sub_contract_costs.total)}", size: 10

move_down 5
text "Bid Expenses                                  #{price(@project.total_bid_expenses)}", size: 10
move_down 5
text "Other Costs                                     #{price(@project.other_costs.total)}", size: 10
move_down 5
stroke_horizontal_rule
move_down 8
text "TOTAL                                             #{price(@project.total_direct_costs)}", size: 10, color: "CC181E"
end
bounding_box([300, y_position], :width => 230, :height => 200) do
transparent(0) { stroke_bounds }
text "COLLECTION", style: :bold, size: 10, color: '4A4A4A'
text "(As of #{Time.zone.now.strftime("%B %e, %Y")})", size: 8, color: "3E3E3E"
move_down 5
text "Contract Amount                #{price(@project.revised_contract_amount)}", size: 10
move_down 5
text "Collected                            #{price(@project.total_payments)}", size: 10
move_down 5
stroke_horizontal_rule
move_down 8
text "REMAINING                       #{price(@project.remaining_payments)}", size: 10, color: "CC181E"
move_down 20
text "REVENUE SUMMARY", style: :bold, size: 10, color: '4A4A4A'
text "(As of #{Time.zone.now.strftime("%B %e, %Y")})", size: 8, color: "3E3E3E"
move_down 5
text "Contract Amount               #{price(@project.revised_contract_amount)}", size: 10
move_down 5
text "Commited Costs               #{price(@project.total_direct_costs)}", size: 10
move_down 5
stroke_horizontal_rule
move_down 8
text "REVENUE                        #{price(@project.revenue)}", size: 10, color: '132361'

end
stroke_horizontal_rule
end
end
