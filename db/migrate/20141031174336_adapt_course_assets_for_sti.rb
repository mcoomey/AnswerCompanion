class AdaptCourseAssetsForSti < ActiveRecord::Migration
  def up
    add_column :course_assets, :type, :string
    rename_table :course_assets, :site_assets
  end

  def down
    drop_column :site_assets, :type
    rename_table :site_assets, :course_assets
    
  end
end
