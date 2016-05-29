class FileAttachment < ActiveRecord::Base
  belongs_to :project
  has_attached_file :attached_file,
                    :path => ":rails_root/public/system/file_attachment/:id/:filename",
                    :url => "/system/file_attachment/:id/:filename"

  validates_attachment :attached_file, presence: true,
                  content_type: { content_type: 
                  	[ "application/pdf",
                    "application/msword",
                  	"application/vnd.ms-office",
                  	"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                    "application/vnd.ms-excel",
                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" ]
                  },
                  message: ' Only EXCEL and WORD files are allowed.'

  validates_presence_of :date, :description
end
