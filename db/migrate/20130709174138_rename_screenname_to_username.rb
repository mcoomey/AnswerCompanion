class RenameScreennameToUsername < ActiveRecord::Migration
  def change
    rename_column :instructors, :screenname, :username
    rename_column :students, :screenname, :username
    add_column :parents, :username, :string
  end
end
