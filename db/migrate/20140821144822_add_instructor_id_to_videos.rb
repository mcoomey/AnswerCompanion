class AddInstructorIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :instructor_id, :integer
  end
end
