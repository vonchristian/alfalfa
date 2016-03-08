class AddStartDateAndEndDateToWorkedDays < ActiveRecord::Migration
  def change
    add_column :worked_days, :start_date, :datetime
    add_column :worked_days, :end_date, :datetime
  end
end
