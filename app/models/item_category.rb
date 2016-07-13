class ItemCategory < ActiveRecord::Base
	has_many :inventories, class_name: 'Supplies::Inventories'

	def to_s
		name.singularize
	end
end