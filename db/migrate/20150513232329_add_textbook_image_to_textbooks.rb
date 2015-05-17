class AddTextbookImageToTextbooks < ActiveRecord::Migration
  def change
    add_column :textbooks, :textbook_image, :string
  end
end
