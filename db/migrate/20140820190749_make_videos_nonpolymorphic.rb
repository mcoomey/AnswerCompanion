class MakeVideosNonpolymorphic < ActiveRecord::Migration
  def up
    remove_column :videos, :newversion_id
    remove_column :videos, :instructor_id
    remove_column :videos, :textbook_id
    remove_column :videos, :videoable_id
    remove_column :videos, :videoable_type
    add_column :videos, :course_asset_id, :integer
  end

  def down
    remove_column :videos, :course_asset_id
    add_column :videos, :videoable_type, :string
    add_column :videos, :videoable_id, :integer
    add_column :videos, :textbook_id, :integer
    add_column :videos, :instructor_id, :integer
    add_column :videos, :newversion_id, :integer
  end
end
