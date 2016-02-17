class Item < ActiveRecord::Base
  belongs_to :division
  def to_s
    "#{code} - #{description}"
  end
end
