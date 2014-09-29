class RemoveFrontcoverFromTextbooks < ActiveRecord::Migration
  def up
    remove_column :textbooks, :frontcover
  end

  def down
    add_column :textbooks, :frontcover, :string
  end
end
