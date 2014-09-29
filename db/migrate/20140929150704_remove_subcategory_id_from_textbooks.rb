class RemoveSubcategoryIdFromTextbooks < ActiveRecord::Migration
  def up
    remove_column :textbooks, :subcategory_id
  end

  def down
    add_column :textbooks, :subcategory_id, :integer
  end
end
