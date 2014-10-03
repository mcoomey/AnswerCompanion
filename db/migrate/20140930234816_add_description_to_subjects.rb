class AddDescriptionToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :description, :string
  end
end
