class AttachmentFile < ActiveRecord::Base
	include PublicActivity::Common

	has_attached_file :attachment_report, 
										:path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                  	:url => "/system/:attachment/:id/:style/:filename"

	validates_attachment_content_type :attachment_report, :content_type => %w(application/pdf application/msword application/vnd.ms-office application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
	
  belongs_to :project
end
