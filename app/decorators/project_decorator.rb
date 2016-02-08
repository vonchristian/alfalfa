class ProjectDecorator < Draper::Decorator
  delegate_all
  
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
  def final_expiry_date
    if project.time_extensions.present?
      project.revised_expiry_date
    else
      project.expiry_date 
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
  def date_created
    object.created_at.strftime("%A, %B %e")
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
      amount_revisions.last.revised_contract_amount
    else
      cost 
    end
  end

end
