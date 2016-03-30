class Worker < ActiveRecord::Base
  enum position:[:laborer, :skilled_laborer, :foreman, :operator, :welder, :driver]
  enum sex:[:male, :female]

  def to_s
    full_name
  end
  def full_name
    "#{first_name} #{middle_name}. #{last_name}"
  end
end
