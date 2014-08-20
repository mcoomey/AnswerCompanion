class CreateTextbookVideos < ActiveRecord::Migration
  def change
    create_table :textbook_videos do |t|
      t.string :videofile
      t.string :length
      t.integer :videofile_processed
      t.string :videoable_type
      t.integer :videoable_id
      t.integer :textbook_id
      t.integer :instructor_id

      t.timestamps
    end
    add_index :textbook_videos, [:videoable_id, :videoable_type]
  end
end
