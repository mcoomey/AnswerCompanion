class CreateCourseAssetModelTypes < ActiveRecord::Migration
  def change
    create_table :course_asset_model_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
