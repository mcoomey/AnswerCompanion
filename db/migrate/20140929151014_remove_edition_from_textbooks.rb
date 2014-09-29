class RemoveEditionFromTextbooks < ActiveRecord::Migration
  def up
    remove_column :textbooks, :edition
  end

  def down
    add_column :textbooks, :edition, :string
  end
end
