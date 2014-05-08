class AddPositionToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :position, :integer
  end
end
