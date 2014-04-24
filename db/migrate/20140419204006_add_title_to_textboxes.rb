class AddTitleToTextboxes < ActiveRecord::Migration
  def change
    add_column :textboxes, :title, :string
  end
end
