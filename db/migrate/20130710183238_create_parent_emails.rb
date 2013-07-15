class CreateParentEmails < ActiveRecord::Migration
  def change
    create_table :parent_emails do |t|
      t.integer :student_id
      t.string :email

      t.timestamps
    end
    
    add_index :parent_emails, [:student_id, :email]
  end
end
