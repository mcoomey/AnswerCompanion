class ChangeStateToStateIdInSchools < ActiveRecord::Migration
  def change
    remove_column :schools, :state
    add_column :schools, :state_id, :integer
  end
end
