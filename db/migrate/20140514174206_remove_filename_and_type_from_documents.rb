class RemoveFilenameAndTypeFromDocuments < ActiveRecord::Migration
  def up
    remove_column :documents, :filename
    remove_column :documents, :type
  end

  def down
    add_column :documents, :filename, :string
    add_column :documents, :type, :string
  end
end
