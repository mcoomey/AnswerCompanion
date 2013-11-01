class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :description
      t.string :filename
      t.string :type
      t.integer :course_asset_id
      t.integer :archived

      t.timestamps
    end
  end
end
