class CreateTextboxes < ActiveRecord::Migration
  def change
    create_table :textboxes do |t|
      t.text :content
      t.integer :course_asset_id
      t.integer :archived

      t.timestamps
    end
  end
end
