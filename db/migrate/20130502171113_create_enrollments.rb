class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :course
      t.references :subject
      t.timestamps
    end
    add_index :enrollments, ['course_id', 'subject_id']
  end
end
