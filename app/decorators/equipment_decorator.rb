class EquipmentDecorator < Draper::Decorator
  delegate_all

  def status
    if active?
      'Active'
    elsif inactive?
      'Inactive'
    end
  end

  def status_color
    if active?
      'success'
    elsif inactive?
      'danger'
    end
  end
  def current_assignment_start_date
    if equipment_schedules.any?
      equipment_schedules.last.start_date.strftime("%B %e, %Y")
    else
      "No Schedule or Equipment is Inactive"
    end
  end

  def current_assignment_id_number_and_location
    if equipment_schedules.present?
      equipment_schedules.last.project.id_number_and_location
    end
  end

  def current_assignment
    if equipment_schedules.present?
      equipment_schedules.last.project.name
    end
  end

  def current_assignment_location
    if equipment_schedules.present?
      equipment_schedules.last.project.address
    end
  end

  def current_assignment_purpose
    if equipment_schedules.present?
      equipment_schedules.last.purpose
    end
  end



  def current_assignment_end_date
    if equipment_schedules.last.end_date.present?
      equipment_schedules.last.end_date.strftime("%B %e, %Y")
    end
  end

  def current_assignment_operator
    if equipment_schedules.present?
      equipment_schedules.last.operator
    end
  end
end
