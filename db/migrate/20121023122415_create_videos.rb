class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :videofile
      t.integer :length
      t.integer :feedback_score
      t.integer :difficulty
      t.integer :numpurchases
      t.boolean :archived
      t.integer :newversion_id
      t.integer :exercise_id
      t.integer :lesson_id
      t.integer :instructor_id
      t.integer :textbook_id

      t.timestamps
    end
  end
end
