class AddPositionToTextbookDelegations < ActiveRecord::Migration
  def change
    add_column :textbook_delegations, :position, :integer
  end
end
