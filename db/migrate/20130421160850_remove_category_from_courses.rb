class RemoveCategoryFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :category_id
    remove_column :courses, :subcategory_id
    rename_column :courses, :description, :term
  end
end
