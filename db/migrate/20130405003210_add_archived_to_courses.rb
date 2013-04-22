class AddArchivedToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :archived, :boolean
  end
end
