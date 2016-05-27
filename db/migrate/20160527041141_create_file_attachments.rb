class CreateFileAttachments < ActiveRecord::Migration
  def change
    create_table :file_attachments do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.datetime :date
      t.text :description

      t.timestamps null: false
    end
  end
end
