class CreateTextbooks < ActiveRecord::Migration
  def change
    create_table :textbooks do |t|
      t.string :isbn13
      t.string :title
      t.string :author
      t.string :publisher
      t.string :edition
      t.string :frontcover
      t.integer :category_id
      t.integer :subcategory_id
      t.string  :userisbn

      t.timestamps
    end
  end
end
