class AddArchivedToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :archived, :boolean
  end
end
