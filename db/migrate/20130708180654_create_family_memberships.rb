class CreateFamilyMemberships < ActiveRecord::Migration
  def change
    create_table :family_memberships do |t|
      t.integer :student_id
      t.integer :familymember_id
      t.string :familymember_type

      t.timestamps
    end
  end
end
