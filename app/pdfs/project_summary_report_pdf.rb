class ProjectSummaryReportPdf < Prawn::Document

  def initialize(project, view_context)
    super(margin: 30, page_size: [612, 948], page_layout: :portrait)
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
    text "Summary Report as of #{Time.zone.now.strftime("%B %e, %Y")}", style: :bold, size: 9
    move_down 5
    text "#{@project.name}", size: 11
  end
  def summary
y_position = cursor - 20
bounding_box([0, y_position], :width => 200, :height => 150) do
transparent(0) { stroke_bounds }
text "PROJECT INFO", style: :bold, size: 10
move_down 5
text "Notice to Proceed       #{@project.notice_to_proceed.date.strftime("%B %e, %Y")}", size: 9
move_down 5
text "Contract Amount         #{price(@project.cost)}", size: 9
move_down 5
text "Project Location         #{@project.address}", size: 9
move_down 5
text "Project Duration         #{@project.duration} Days", size: 9
end
bounding_box([300, y_position], :width => 200, :height => 150) do
transparent(0) { stroke_bounds } # This will stroke on one page
text "PROJECT STATUS",  style: :bold, size: 10
move_down 5
text "Target Accomplishment         #{@project.target_accomplishment.round(2)} %", size: 9, color: "0F599C"
move_down 5
text "Actual Accomplishment         #{@project.actual_accomplishment.round(2)} %", size: 9, color: "5FBA7D"
move_down 5

text "Slippage                                #{@project.slippage.round(2)} %", size: 9, color: "FF4F61"
end
stroke_horizontal_rule
end
def costs
y_position = cursor - 20
bounding_box([0, y_position], :width => 250, :height => 130) do
transparent(0) { stroke_bounds }
text "DIRECT COSTS", style: :bold, size: 10
text "(As of #{Time.zone.now.strftime("%B %e, %Y")})", size: 8, color: "3E3E3E"
move_down 5
text "Materials                                          #{price(@project.direct_material_costs)}", size: 10
move_down 5
text "Labor                                               #{price(@project.labor_costs.total)}", size: 10
move_down 5
text "Equipment                                       #{price(@project.equipment_costs.total)}", size: 10
move_down 5
text "Other Costs                                     #{price(@project.other_costs.total)}", size: 10
move_down 5
stroke_horizontal_rule
move_down 5
text "TOTAL                                             #{price(@project.other_costs.total)}", size: 10
end

stroke_horizontal_rule
end
end
