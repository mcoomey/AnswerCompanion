class RemoveUserisbnFromTextbooks < ActiveRecord::Migration
  def up
    remove_column :textbooks, :userisbn
  end

  def down
    add_column :textbooks, :userisbn, :string
  end
end
