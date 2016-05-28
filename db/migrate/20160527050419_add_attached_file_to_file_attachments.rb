class AddAttachedFileToFileAttachments < ActiveRecord::Migration
  def up
    add_attachment :file_attachments, :attached_file
  end

  def down
    remove_attachment :file_attachments, :attached_file
  end
end
