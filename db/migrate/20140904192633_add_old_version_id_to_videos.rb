class AddOldVersionIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :old_version_id, :integer
  end
end
