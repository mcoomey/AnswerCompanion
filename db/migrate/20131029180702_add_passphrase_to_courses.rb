class AddPassphraseToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :passphrase, :string
  end
end
