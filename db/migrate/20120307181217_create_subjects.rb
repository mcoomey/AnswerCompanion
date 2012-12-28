class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
			t.references :subjectable, :polymorphic => true
      t.integer  "category_id"
      t.integer  "subcategory_id"
      
      t.timestamps
    end
  end
end
