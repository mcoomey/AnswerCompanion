class CreateInstructorsSchoolsJoin < ActiveRecord::Migration
  def up
    create_table :instructors_schools, :id => false do |t|
      t.integer "instructor_id"
      t.integer "school_id"
    end
    add_index :instructors_schools, ["instructor_id", "school_id"]
  end

  def down
    drop_table :instructors_schools
  end
end
