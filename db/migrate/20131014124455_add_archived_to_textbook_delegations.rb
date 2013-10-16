class AddArchivedToTextbookDelegations < ActiveRecord::Migration
  def change
    add_column :textbook_delegations, :archived, :integer
  end
end
