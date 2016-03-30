class Attachment < ActiveRecord::Base
	include PublicActivity::Common

	attachment :attachment_file
	
  belongs_to :project
end
