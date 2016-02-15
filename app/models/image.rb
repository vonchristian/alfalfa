class Image < ActiveRecord::Base
  belongs_to :accomplishment
  attachment :file
end
