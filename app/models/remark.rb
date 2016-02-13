class Remark < ActiveRecord::Base
  belongs_to :project
  belongs_to :remarker, class_name: 'User', foreign_key: 'remarker_id'
end
