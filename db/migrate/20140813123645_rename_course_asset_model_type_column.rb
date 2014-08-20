class RenameCourseAssetModelTypeColumn < ActiveRecord::Migration
  def change
    rename_column :course_asset_model_types, :model_name, :name_of_model
  end
end
