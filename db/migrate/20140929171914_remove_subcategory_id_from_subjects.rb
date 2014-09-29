class RemoveSubcategoryIdFromSubjects < ActiveRecord::Migration
  def up
    remove_column :subjects, :subcategory_id
  end

  def down
    add_column :subjects, :subcategory_id, :integer
  end
end
