class ChangeVideoLengthColumnToString < ActiveRecord::Migration
  def change
    change_column :videos, :length, :string
  end

end
