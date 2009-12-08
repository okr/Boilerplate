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

ActiveRecord::Schema.define(:version => 20091202083301) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "cached_slug"
    t.integer  "photos_count", :default => 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.string   "tagline"
    t.integer  "position"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["position"], :name => "index_categories_on_position"

  create_table "contact_forms", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "location"
    t.string   "street"
    t.string   "city_town"
    t.string   "description"
    t.datetime "start"
    t.datetime "end"
    t.string   "cached_slug"
    t.integer  "user_id"
    t.integer  "event_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["end"], :name => "index_events_on_end"
  add_index "events", ["start"], :name => "index_events_on_start"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.boolean  "admin",            :default => false
    t.integer  "user_id"
    t.string   "cached_slug"
    t.integer  "link_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["admin"], :name => "index_links_on_admin"
  add_index "links", ["user_id"], :name => "index_links_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.boolean  "published",        :default => false
    t.boolean  "home",             :default => false
    t.integer  "user_id"
    t.string   "cached_slug"
    t.integer  "page_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["home"], :name => "index_pages_on_home"
  add_index "pages", ["position"], :name => "index_pages_on_position"
  add_index "pages", ["published"], :name => "index_pages_on_published"
  add_index "pages", ["user_id"], :name => "index_pages_on_user_id"

  create_table "photos", :force => true do |t|
    t.string   "title"
    t.string   "caption"
    t.integer  "position"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_w"
    t.integer  "crop_h"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["attachable_id", "attachable_type"], :name => "index_photos_on_attachable_id_and_attachable_type"
  add_index "photos", ["position"], :name => "index_photos_on_position"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published",        :default => false
    t.integer  "user_id"
    t.string   "cached_slug"
    t.integer  "post_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["published"], :name => "index_posts_on_published"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "preferences", :force => true do |t|
    t.string   "title"
    t.string   "tagline"
    t.string   "blog_title"
    t.string   "analytics_key"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.string  "taggable_type", :default => ""
    t.integer "taggable_id"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name", :default => ""
    t.string "kind", :default => ""
  end

  add_index "tags", ["name", "kind"], :name => "index_tags_on_name_and_kind"

  create_table "timeline_events", :force => true do |t|
    t.string   "event_type"
    t.string   "subject_type"
    t.string   "actor_type"
    t.string   "secondary_subject_type"
    t.integer  "subject_id"
    t.integer  "actor_id"
    t.integer  "secondary_subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                :null => false
    t.string   "name"
    t.text     "profile"
    t.string   "email",                :default => "", :null => false
    t.string   "string",               :default => "", :null => false
    t.string   "crypted_password",                     :null => false
    t.string   "password_salt",                        :null => false
    t.string   "remember_token"
    t.string   "password_reset_token", :default => "", :null => false
    t.string   "persistence_token",                    :null => false
    t.string   "single_access_token",                  :null => false
    t.string   "perishable_token",                     :null => false
    t.integer  "login_count",          :default => 0,  :null => false
    t.integer  "failed_login_count",   :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "role_id"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["password_reset_token"], :name => "index_users_on_password_reset_token"
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
