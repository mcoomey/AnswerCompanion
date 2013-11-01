class AddCourseAssetIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :course_asset_id, :integer
  end
end
