class ChangeCourseArchiveColToInteger < ActiveRecord::Migration
  def up
    change_column :courses, :archived, :integer
  end

  def down
    change_column :courses, :archived, :boolean
  end
end
