# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150513232329) do

  create_table "course_asset_model_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "name_of_model"
  end

  create_table "course_assets", :force => true do |t|
    t.string   "name"
    t.integer  "model_type"
    t.integer  "assetable_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "position"
    t.string   "assetable_type"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "section"
    t.integer  "instructor_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "term"
    t.integer  "archived"
    t.string   "passphrase"
    t.integer  "position"
  end

  add_index "courses", ["instructor_id"], :name => "index_courses_on_instructor_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "documents", :force => true do |t|
    t.string   "description"
    t.integer  "course_asset_id"
    t.integer  "archived"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "position"
    t.string   "docfile"
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "course_id"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "enrollments", ["course_id", "subject_id"], :name => "index_enrollments_on_course_id_and_subject_id"

  create_table "exercises", :force => true do |t|
    t.string   "number"
    t.string   "page"
    t.integer  "section_title_id"
    t.integer  "textbook_id"
    t.integer  "instructor_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "instructors", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.integer  "emailpref",              :default => 0
    t.string   "paypalaccount"
    t.integer  "privilege",              :default => 0
    t.string   "grade"
    t.float    "accountbalance",         :default => 0.0
    t.integer  "violationcount",         :default => 0
    t.boolean  "deactivated",            :default => false
  end

  add_index "instructors", ["confirmation_token"], :name => "index_instructors_on_confirmation_token", :unique => true
  add_index "instructors", ["email"], :name => "index_instructors_on_email", :unique => true
  add_index "instructors", ["reset_password_token"], :name => "index_instructors_on_reset_password_token", :unique => true
  add_index "instructors", ["unlock_token"], :name => "index_instructors_on_unlock_token", :unique => true

  create_table "lessons", :force => true do |t|
    t.string   "title"
    t.string   "page"
    t.integer  "textbook_id"
    t.integer  "instructor_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "links", :force => true do |t|
    t.string   "description"
    t.string   "url"
    t.integer  "course_asset_id"
    t.integer  "archived"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "position"
  end

  create_table "parent_emails", :force => true do |t|
    t.integer  "student_id"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "parent_emails", ["student_id", "email"], :name => "index_parent_emails_on_student_id_and_email"

  create_table "parents", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "deactivated",            :default => false
    t.string   "username"
  end

  add_index "parents", ["email"], :name => "index_parents_on_email", :unique => true
  add_index "parents", ["reset_password_token"], :name => "index_parents_on_reset_password_token", :unique => true

  create_table "role_assignments", :force => true do |t|
    t.integer  "role_id"
    t.string   "roleable_type"
    t.integer  "roleable_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "school_memberships", :force => true do |t|
    t.integer  "school_id"
    t.integer  "schoolmember_id"
    t.string   "schoolmember_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "school_memberships", ["schoolmember_id", "schoolmember_type"], :name => "index_school_memberships_on_id_and_type"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "town"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "section_titles", :force => true do |t|
    t.string   "name"
    t.integer  "textbook_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "site_assets", :force => true do |t|
    t.string   "name"
    t.integer  "model_type"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
    t.string   "type"
  end

  create_table "students", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.integer  "emailpref",              :default => 0
    t.string   "paypalaccount"
    t.integer  "privilege",              :default => 0
    t.string   "grade"
    t.float    "accountbalance",         :default => 0.0
    t.integer  "violationcount",         :default => 0
    t.boolean  "deactivated",            :default => false
  end

  add_index "students", ["confirmation_token"], :name => "index_students_on_confirmation_token", :unique => true
  add_index "students", ["email"], :name => "index_students_on_email", :unique => true
  add_index "students", ["reset_password_token"], :name => "index_students_on_reset_password_token", :unique => true
  add_index "students", ["unlock_token"], :name => "index_students_on_unlock_token", :unique => true

  create_table "subject_assets", :force => true do |t|
    t.string   "name"
    t.integer  "model_type"
    t.integer  "subject_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.integer  "student_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "archived"
    t.string   "term"
    t.string   "description"
    t.integer  "position"
  end

  create_table "textbook_delegations", :force => true do |t|
    t.integer  "textbook_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "course_asset_id"
    t.integer  "archived"
    t.integer  "position"
  end

  add_index "textbook_delegations", ["course_asset_id"], :name => "index_textbook_delegations_on_textable_id_and_textable_type"
  add_index "textbook_delegations", ["textbook_id"], :name => "index_textbook_delegations_on_textbook_id_and_subject_id"

  create_table "textbook_videos", :force => true do |t|
    t.string   "videofile"
    t.string   "length"
    t.integer  "videofile_processed"
    t.string   "videoable_type"
    t.integer  "videoable_id"
    t.integer  "textbook_id"
    t.integer  "instructor_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "old_version_id"
  end

  add_index "textbook_videos", ["videoable_id", "videoable_type"], :name => "index_textbook_videos_on_videoable_id_and_videoable_type"

  create_table "textbooks", :force => true do |t|
    t.string   "isbn13"
    t.string   "title"
    t.string   "author"
    t.string   "publisher"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "image_link"
    t.string   "textbook_image"
  end

  create_table "textboxes", :force => true do |t|
    t.text     "content"
    t.integer  "course_asset_id"
    t.integer  "archived"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "position"
    t.string   "title"
  end

  create_table "videos", :force => true do |t|
    t.string   "videofile"
    t.string   "length"
    t.integer  "archived"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "videofile_processed"
    t.string   "title"
    t.string   "description"
    t.integer  "position"
    t.integer  "course_asset_id"
    t.integer  "instructor_id"
    t.integer  "old_version_id"
  end

end
