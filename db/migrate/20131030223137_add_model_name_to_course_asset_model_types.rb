class AddModelNameToCourseAssetModelTypes < ActiveRecord::Migration
  def change
    add_column :course_asset_model_types, :model_name, :string
  end
end
