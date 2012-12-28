class AddInstructorIdToTextbooks < ActiveRecord::Migration
  def change
    add_column :textbooks, :instructor_id, :integer

  end
end
