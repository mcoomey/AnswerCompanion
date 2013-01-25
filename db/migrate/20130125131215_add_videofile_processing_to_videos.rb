class AddVideofileProcessingToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :videofile_processing, :boolean

  end
end
