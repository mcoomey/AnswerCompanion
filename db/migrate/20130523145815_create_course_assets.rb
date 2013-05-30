class CreateCourseAssets < ActiveRecord::Migration
  def change
    create_table :course_assets do |t|
      t.string :name
      t.integer :type
      t.references :course

      t.timestamps
    end
    add_index :course_assets, :course_id
  end
end
