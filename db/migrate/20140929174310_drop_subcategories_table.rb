class DropSubcategoriesTable < ActiveRecord::Migration
  def up
    drop_table :subcategories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
