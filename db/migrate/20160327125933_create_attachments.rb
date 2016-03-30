class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.string :attachment_file_id
      t.text :description

      t.timestamps null: false
    end
  end
end
