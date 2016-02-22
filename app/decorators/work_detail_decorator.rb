class WorkDetailDecorator < Draper::Decorator
  decorates :work_detail
  delegate_all
def slippage_sign
     if object.slippage.negative?
    'down text-danger'
  elsif object.slippage.positive?
    'up text-success'
  end
end
def slippage_color
     if object.slippage.negative?
    'text-danger'
  elsif object.slippage.positive?
    'text-success'
  end
end
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
