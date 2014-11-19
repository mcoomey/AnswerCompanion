class MakeCourseAssetPolymorphic < ActiveRecord::Migration
  def change
    rename_column :course_assets, :course_id, :assetable_id
    add_column :course_assets, :assetable_type, :string
  end
end
