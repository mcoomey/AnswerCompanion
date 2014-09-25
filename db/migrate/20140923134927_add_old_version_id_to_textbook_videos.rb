class AddOldVersionIdToTextbookVideos < ActiveRecord::Migration
  def change
    add_column :textbook_videos, :old_version_id, :integer
  end
end
