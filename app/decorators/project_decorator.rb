class ProjectDecorator < Draper::Decorator
  delegate_all
 
  def sign
    if project.road?
    'road'
  end
end

  def start_date_to_end_date
    if project.notice_to_proceed.present?
      "#{project.start_date.strftime("%D")} to #{project.final_expiry_date.strftime("%D")}"
    else
      "No NTP"
    end
  end
  def end_date
     "#{project.final_expiry_date.strftime("%b %e, %Y")}"
   end

  def notice_to_proceed_link(project)
    if project.notice_to_proceed.blank?
      link_to 'Enter NTP Date', new_project_notice_to_proceed_path(project)
    else
      project.ntp 
    end
  end
  def slippage_sign
     if project.slippage.negative?
    'down'
  else
    'up'
  end
end

  def slippage_color
    if project.slippage.negative?
    'red'
  else
    'green'
  end
end
  

  def ntp
    if project.notice_to_proceed
      project.notice_to_proceed.date.to_date.strftime("%B %d, %Y")
    else
      "No NTP yet"
    end
  end

  def days_elapsed
    if project.notice_to_proceed
       ((notice_to_proceed.date.to_i - Time.zone.now.to_i)/86400).abs
    else
       "No NTP yet."
    end
  end

  def percent_accomplished
    if project.accomplishments.any?
     "#{project.accomplishments.last.percent }%"
    else
      "No Accomplishment yet."
    end
  end

  def final_cost
    if project.amount_revisions.present?
      project.cost + project.amount_revisions.sum(:revised_contract_amount)
    else
      "No Revision"
    end
  end

end
