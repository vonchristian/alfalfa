class ItemCategory < ActiveRecord::Base
	has_many :inventories, class_name: 'Supplies::Inventories'

	def to_s
		name
	end
end