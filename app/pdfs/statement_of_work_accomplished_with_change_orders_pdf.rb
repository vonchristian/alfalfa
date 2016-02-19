class StatementOfWorkAccomplishedWithChangeOrdersPdf < Prawn::Document
  def initialize(project, view_context)
    @project = project
    @view_context = view_context
  end
end
