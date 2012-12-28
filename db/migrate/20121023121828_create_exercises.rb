class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :number
      t.string :page
      t.integer :section_title_id
      t.integer :textbook_id
      t.integer :instructor_id

      t.timestamps
    end
  end
end
