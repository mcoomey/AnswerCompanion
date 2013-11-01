class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :description
      t.string :url
      t.integer :course_asset_id
      t.integer :archived

      t.timestamps
    end
  end
end
