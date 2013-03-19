class AddVideofileProcessedToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :videofile_processed, :integer

  end
end