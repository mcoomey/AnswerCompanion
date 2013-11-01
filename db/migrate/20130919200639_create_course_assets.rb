class CreateCourseAssets < ActiveRecord::Migration
  def change
    create_table :course_assets do |t|
      t.string :name
      t.integer :model_type
      t.integer :course_id
      t.string :ancestry

      t.timestamps
    end
    add_index :course_assets, :ancestry
  end
end
