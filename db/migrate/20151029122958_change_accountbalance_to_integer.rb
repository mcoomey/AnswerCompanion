class ChangeAccountbalanceToInteger < ActiveRecord::Migration
  def up
    change_column :instructors, :accountbalance, :integer
    change_column :students, :accountbalance, :integer
  end

  def down
    change_column :instructors, :accountbalance, :float
    change_column :students, :accountbalance, :float
  end
end
