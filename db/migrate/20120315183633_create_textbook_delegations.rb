class CreateTextbookDelegations < ActiveRecord::Migration
  def change
    create_table :textbook_delegations do |t|
			t.references :textbook
      t.references :subject
      t.timestamps
    end
    add_index :textbook_delegations, ['textbook_id', 'subject_id']
  end
end
