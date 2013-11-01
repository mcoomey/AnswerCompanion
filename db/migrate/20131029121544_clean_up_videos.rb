class CleanUpVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :feedback_score
    remove_column :videos, :difficulty
    remove_column :videos, :numpurchases
  end

  def down
    add_column :videos, :feedback_score, :integer
    add_column :videos, :difficulty, :integer
    add_column :videos, :numpurchases, :integer
  end
end
