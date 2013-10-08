class RemovePolyFromTextbookDelegation < ActiveRecord::Migration
  def change
    remove_column :textbook_delegations, :textable_type
    rename_column :textbook_delegations, :textable_id, :course_asset_id
  end
end
