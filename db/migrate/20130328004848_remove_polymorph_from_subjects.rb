class RemovePolymorphFromSubjects < ActiveRecord::Migration
  def change
    rename_column :subjects, :subjectable_id, :student_id
    remove_column :subjects, :subjectable_type
  end
end
