class ChangeVideoArchivedToInteger < ActiveRecord::Migration
  def change
    change_column :videos, :archived, :integer
  end
end
