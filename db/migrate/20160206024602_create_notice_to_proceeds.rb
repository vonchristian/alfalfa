class CreateNoticeToProceeds < ActiveRecord::Migration
  def change
    create_table :notice_to_proceeds do |t|
      t.datetime :date
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
