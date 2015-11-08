class AddPassphraseToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :passphrase, :string
  end
end
