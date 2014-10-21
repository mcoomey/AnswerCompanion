class CreateSubjectAssets < ActiveRecord::Migration
  def change
    create_table :subject_assets do |t|
      t.string :name
      t.integer :model_type
      t.integer :subject_id
      t.integer :position
      t.timestamps
    end
  end
end
