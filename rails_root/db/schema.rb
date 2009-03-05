# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 2) do

  create_table "acl_sections", :force => true do |t|
    t.string "description", :limit => 230, :null => false
  end

  add_index "acl_sections", ["description"], :name => "index_acl_sections_on_description", :unique => true

  create_table "acls", :force => true do |t|
    t.integer  "section_id"
    t.boolean  "allow",      :default => true, :null => false
    t.boolean  "enabled",    :default => true, :null => false
    t.string   "note"
    t.datetime "updated_at",                   :null => false
  end

  add_index "acls", ["note"], :name => "index_acls_on_note", :unique => true
  add_index "acls", ["updated_at"], :name => "index_acls_on_updated_at"
  add_index "acls", ["section_id"], :name => "index_acls_on_section_id"
  add_index "acls", ["enabled"], :name => "index_acls_on_enabled"

  create_table "acls_privileges", :id => false, :force => true do |t|
    t.integer "acl_id",       :null => false
    t.integer "privilege_id", :null => false
  end

  add_index "acls_privileges", ["acl_id", "privilege_id"], :name => "index_acls_privileges_on_acl_id_and_privilege_id", :unique => true

  create_table "categories", :force => true do |t|
    t.string  "description", :null => false
    t.integer "lft",         :null => false
    t.integer "rgt",         :null => false
    t.integer "parent_id"
  end

  add_index "categories", ["rgt"], :name => "index_categories_on_rgt", :unique => true
  add_index "categories", ["lft"], :name => "index_categories_on_lft", :unique => true

  create_table "controller_actions", :force => true do |t|
    t.string  "controller",          :null => false
    t.string  "action",              :null => false
    t.integer "controller_group_id", :null => false
  end

  add_index "controller_actions", ["controller", "action"], :name => "index_controller_actions_on_controller_and_action", :unique => true

  create_table "controller_groups", :force => true do |t|
    t.string  "description", :null => false
    t.integer "lft"
    t.integer "rgt"
    t.integer "parent_id"
  end

  add_index "controller_groups", ["parent_id"], :name => "index_controller_groups_on_parent_id"
  add_index "controller_groups", ["rgt"], :name => "index_controller_groups_on_rgt"
  add_index "controller_groups", ["lft"], :name => "index_controller_groups_on_lft"
  add_index "controller_groups", ["description"], :name => "index_controller_groups_on_description"

  create_table "forums", :force => true do |t|
    t.string  "name",        :null => false
    t.string  "tag"
    t.string  "type",        :null => false
    t.integer "category_id", :null => false
  end

  add_index "forums", ["category_id"], :name => "index_forums_on_category_id"
  add_index "forums", ["type"], :name => "index_forums_on_type"

  create_table "privileges", :force => true do |t|
    t.string "section",     :limit => 230, :null => false
    t.string "value",       :limit => 230, :null => false
    t.string "description", :limit => 230
  end

  add_index "privileges", ["section", "value"], :name => "index_privileges_on_section_and_value", :unique => true

  create_table "requester_group_links", :force => true do |t|
    t.integer "acl_id",               :null => false
    t.integer "requester_group_id",   :null => false
    t.string  "requester_group_type", :null => false
  end

  add_index "requester_group_links", ["requester_group_type", "requester_group_id"], :name => "requester_group_links_join_index2"
  add_index "requester_group_links", ["acl_id", "requester_group_id", "requester_group_type"], :name => "requester_group_links_join_index_1", :unique => true

  create_table "requester_links", :force => true do |t|
    t.integer "acl_id",         :null => false
    t.integer "requester_id",   :null => false
    t.string  "requester_type", :null => false
  end

  add_index "requester_links", ["requester_id"], :name => "index_requester_links_on_requester_id"
  add_index "requester_links", ["requester_type", "requester_id"], :name => "requester_links_join_index_2"
  add_index "requester_links", ["acl_id", "requester_id", "requester_type"], :name => "requester_links_join_index_1", :unique => true

  create_table "target_group_links", :force => true do |t|
    t.integer "acl_id",            :null => false
    t.integer "target_group_id",   :null => false
    t.string  "target_group_type", :null => false
  end

  add_index "target_group_links", ["target_group_type", "target_group_id"], :name => "target_group_links_join_index_2"
  add_index "target_group_links", ["acl_id", "target_group_id", "target_group_type"], :name => "target_group_links_join_index_1", :unique => true

  create_table "target_links", :force => true do |t|
    t.integer "acl_id",      :null => false
    t.integer "target_id",   :null => false
    t.string  "target_type", :null => false
  end

  add_index "target_links", ["target_id"], :name => "index_target_links_on_target_id"
  add_index "target_links", ["target_type", "target_id"], :name => "target_links_join_index_2"
  add_index "target_links", ["acl_id", "target_id", "target_type"], :name => "target_links_join_index_1", :unique => true

  create_table "user_groups", :force => true do |t|
    t.string  "description", :null => false
    t.integer "lft",         :null => false
    t.integer "rgt",         :null => false
    t.integer "parent_id"
  end

  add_index "user_groups", ["rgt"], :name => "index_user_groups_on_rgt", :unique => true
  add_index "user_groups", ["lft"], :name => "index_user_groups_on_lft", :unique => true

  create_table "user_groups_users", :id => false, :force => true do |t|
    t.integer "user_id",       :null => false
    t.integer "user_group_id", :null => false
  end

  add_index "user_groups_users", ["user_group_id"], :name => "index_user_groups_users_on_user_group_id"
  add_index "user_groups_users", ["user_id", "user_group_id"], :name => "index_user_groups_users_on_user_id_and_user_group_id", :unique => true

  create_table "users", :force => true do |t|
    t.string "login", :null => false
    t.string "type",  :null => false
  end

  add_index "users", ["type"], :name => "index_users_on_type"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
