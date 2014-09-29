class RemoveAncestryFromCourseAssets < ActiveRecord::Migration
  def up
    remove_column :course_assets, :Ancestry
  end

  def down
    add_column :course_assets, :Ancestry, :string
  end
end
