class RemoveSchoolFromInstructor < ActiveRecord::Migration
  def change
    remove_column :instructors, :school
  end
end
