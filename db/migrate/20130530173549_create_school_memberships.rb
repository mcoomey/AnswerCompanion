class CreateSchoolMemberships < ActiveRecord::Migration
  def change
    create_table :school_memberships do |t|
      t.integer :school_id
      t.integer :schoolmember_id
      t.string :schoolmember_type

      t.timestamps
    end
    add_index :school_memberships, [:schoolmember_id, :schoolmember_type], :name => 'index_school_memberships_on_id_and_type'
  end
end
