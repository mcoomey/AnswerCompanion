class AddPositionToCourseAssets < ActiveRecord::Migration
  def change
    add_column :course_assets, :position, :integer
  end
end
