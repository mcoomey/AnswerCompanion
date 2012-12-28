class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :page
      t.integer :textbook_id
      t.integer :instructor_id

      t.timestamps
    end
  end
end
