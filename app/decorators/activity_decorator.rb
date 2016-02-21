class ActivityDecorator < Draper::Decorator
  delegate_all

def icon
if object.trackable_type=="WorkDetail"
  "fa fa-bookmark text-yellow"
elsif object.trackable_type=="Contract"
  " fa fa-circle-o text-success"
end
end

end
