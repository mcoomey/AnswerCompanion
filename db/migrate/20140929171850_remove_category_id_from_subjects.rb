class RemoveCategoryIdFromSubjects < ActiveRecord::Migration
  def up
    remove_column :subjects, :category_id
  end

  def down
    add_column :subjects, :category_id, :integer
  end
end
