class ProjectBilling < ActiveRecord::Base
  belongs_to :project
  belongs_to :contractor
  has_many :billings
  accepts_nested_attributes_for :billings, reject_if: :all_blank, allow_destroy: true
end
