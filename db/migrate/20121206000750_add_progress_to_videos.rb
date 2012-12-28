class AddProgressToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :progress, :float

  end
end
