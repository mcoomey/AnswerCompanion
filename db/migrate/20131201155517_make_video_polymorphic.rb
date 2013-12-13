class MakeVideoPolymorphic < ActiveRecord::Migration
  def up
    add_column :videos, :videoable_id, :integer
    add_column :videos, :videoable_type, :string
    remove_column :videos, :exercise_id
    remove_column :videos, :lesson_id
    remove_column :videos, :course_asset_id
    
    add_index :videos, [:videoable_id, :videoable_type]
  end
  
  def down
    remove_column :videos, :videoable_id
    remove_column :videos, :videoable_type
    add_column :videos, :exercise_id, :integer
    add_column :videos, :lesson_id, :integer
    add_column :videos, :course_asset_id, :integer
  end
end
