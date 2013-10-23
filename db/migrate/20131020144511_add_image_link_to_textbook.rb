class AddImageLinkToTextbook < ActiveRecord::Migration
  def change
    add_column :textbooks, :image_link, :string
  end
end
