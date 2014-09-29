class RemoveInstructorIdFromTextbooks < ActiveRecord::Migration
  def up
    remove_column :textbooks, :instructor_id
  end

  def down
    add_column :textbooks, :instructor_id, :integer
  end
end
