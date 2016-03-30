class AddAttachmentReportToAttachmentFiles < ActiveRecord::Migration
  def up
    add_attachment :attachment_files, :attachment_report
  end

  def down
    remove_attachment :attachment_files, :attachment_report
  end
end
