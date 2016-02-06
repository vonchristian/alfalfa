class ProjectDecorator < Draper::Decorator
  delegate_all

  def date_created
    object.created_at.strftime("%A, %B %e")
  end

  def percent_accomplished
    if project.accomplishments.any?
      project.accomplishments.last.percent 
    else
      "No Accomplishment yet."
    end
  end

end
