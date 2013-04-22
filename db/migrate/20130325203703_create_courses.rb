class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :section
      t.references :instructor
      t.references :category
      t.references :subcategory

      t.timestamps
    end
    add_index :courses, :instructor_id
    add_index :courses, :category_id
    add_index :courses, :subcategory_id
  end
end
