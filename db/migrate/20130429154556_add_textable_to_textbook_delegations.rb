class AddTextableToTextbookDelegations < ActiveRecord::Migration
  def self.up
    change_table :textbook_delegations do |t|
      t.references :textable, :polymorphic => true
    end
    remove_column :textbook_delegations, :subject_id
    add_index :textbook_delegations, [:textable_id, :textable_type]
  end
  
  def self.down
    change_table :textbook_delegations do |t|
      t.remove_references :textable, :polymorphic => true
    end
    add_column :textbook_delegations, :subject_id, :integer
  end
end
