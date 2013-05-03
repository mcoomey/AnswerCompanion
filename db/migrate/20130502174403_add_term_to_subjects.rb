class AddTermToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :term, :string
  end
end
