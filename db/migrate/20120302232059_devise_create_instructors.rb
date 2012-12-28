class DeviseCreateInstructors < ActiveRecord::Migration
  def change
    create_table(:instructors) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Encryptable
      # t.string :password_salt

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token

      t.timestamps
      
      t.string   "firstname"
      t.string   "lastname"
      t.string   "screenname"
      t.integer  "emailpref",              :default => 0
      t.string   "paypalaccount"
      t.integer  "role",                   :default => 0
      t.integer  "privilege",              :default => 0
      t.string   "grade"
      t.string   "school"
      t.float    "accountbalance",         :default => 0.0
      t.integer  "violationcount",         :default => 0
      t.boolean  "deactivated",            :default => false

    end

    add_index :instructors, :email,                :unique => true
    add_index :instructors, :reset_password_token, :unique => true
    add_index :instructors, :confirmation_token,   :unique => true
    add_index :instructors, :unlock_token,         :unique => true
    # add_index :instructors, :authentication_token, :unique => true
  end
end
