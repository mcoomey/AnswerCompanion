class CreateRoleAssignments < ActiveRecord::Migration
  def change
    create_table :role_assignments do |t|
      t.integer :role_id
      t.string :roleable_type
      t.integer :roleable_id

      t.timestamps
    end
  end
end
