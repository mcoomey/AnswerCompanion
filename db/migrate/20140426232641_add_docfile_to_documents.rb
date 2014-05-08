class AddDocfileToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :docfile, :string
  end
end
