class RemoveSchoolFromStudent < ActiveRecord::Migration
  def change
    remove_column :students, :school
  end

end
