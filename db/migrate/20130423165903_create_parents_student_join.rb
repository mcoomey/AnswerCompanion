class CreateParentsStudentJoin < ActiveRecord::Migration
  
  def up
    create_table :parents_students, :id => false do |t|
      t.integer "parent_id"
      t.integer "student_id"
    end
    add_index :parents_students, ["parent_id", "student_id"]
  end

  def down
    drop_table :parents_students
  end
end
