class AddPositionToTextboxes < ActiveRecord::Migration
  def change
    add_column :textboxes, :position, :integer
  end
end
