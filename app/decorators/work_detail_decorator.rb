class WorkDetailDecorator < Draper::Decorator
  decorates :work_detail
  delegate_all

 def accomplishment_icon
  if object.accomplished?
    "check"
  else
    "exclamation"
  end
end

def accomplishment_color
   if object.accomplished?
    "success"
  elsif object.has_remaining_work?
    "yellow"
    elsif object.work_accomplishments.empty?
    "danger"
  end
end
end
