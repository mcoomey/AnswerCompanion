class AddAncestryToCourseAsset < ActiveRecord::Migration
  def change
    add_column :course_assets, :ancestry, :string
    add_index :course_assets, :ancestry
  end

end
