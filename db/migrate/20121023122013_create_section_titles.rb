class CreateSectionTitles < ActiveRecord::Migration
  def change
    create_table :section_titles do |t|
      t.string :name
      t.integer :textbook_id

      t.timestamps
    end
  end
end
