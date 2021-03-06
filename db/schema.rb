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

ActiveRecord::Schema.define(:version => 20140722011549) do

  create_table "activities", :force => true do |t|
    t.integer  "activitable_id"
    t.string   "activitable_type"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "action"
  end

  add_index "activities", ["activitable_type"], :name => "index_activities_on_activitable_type"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

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

  create_table "directions", :force => true do |t|
    t.integer  "user_id"
    t.string   "zipcode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "product_id"
    t.string   "name"
    t.string   "street"
    t.string   "suburb"
    t.string   "town"
    t.string   "state"
  end

  add_index "directions", ["user_id"], :name => "index_directions_on_user_id"

  create_table "feedbacks", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "token"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.string   "cover"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "picture"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  add_index "groups", ["user_id"], :name => "index_groups_on_user_id"

  create_table "items", :force => true do |t|
    t.string   "description"
    t.integer  "gallery_id"
    t.string   "gallery_token"
    t.integer  "micropost_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "memberships", ["group_id"], :name => "index_memberships_on_group_id"
  add_index "memberships", ["user_id", "group_id"], :name => "index_memberships_on_user_id_and_group_id", :unique => true
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "microposts", :force => true do |t|
    t.text     "url"
    t.text     "provider"
    t.string   "title"
    t.text     "description"
    t.text     "thumbnail"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "status"
    t.string   "picture"
    t.integer  "group_id"
  end

  add_index "microposts", ["group_id"], :name => "index_microposts_on_group_id"
  add_index "microposts", ["status"], :name => "index_microposts_on_status"
  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "newsletters", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "imagen"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "url"
  end

  create_table "notifications", :force => true do |t|
    t.boolean  "follow",        :default => true
    t.boolean  "lov_item",      :default => true
    t.boolean  "lov_post",      :default => true
    t.boolean  "lov_micropost", :default => true
    t.integer  "user_id",       :default => 1
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "paintings", :force => true do |t|
    t.string   "image"
    t.string   "name"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "paintings", ["product_id"], :name => "index_paintings_on_product_id"

  create_table "partners", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "category"
    t.string   "brand"
    t.string   "website"
    t.string   "city"
    t.string   "address"
    t.string   "zipcode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "paypal"
    t.string   "skype"
  end

  add_index "partners", ["user_id"], :name => "index_partners_on_user_id"

  create_table "pays", :force => true do |t|
    t.integer  "plan_id"
    t.string   "email"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "product_id"
    t.string   "paypal_customer_token"
    t.string   "paypal_recurring_profile_token"
  end

  create_table "pictures", :force => true do |t|
    t.integer  "project_id"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "position"
  end

  create_table "pins", :force => true do |t|
    t.string   "description"
    t.integer  "gallery_id"
    t.string   "gallery_token"
    t.integer  "micropost_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "quote"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "status",     :default => false
  end

  add_index "posts", ["status"], :name => "index_posts_on_status"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "products", :force => true do |t|
    t.string   "brand"
    t.string   "description"
    t.string   "picture"
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.decimal  "shipping"
    t.decimal  "total_price"
    t.decimal  "ship_int"
    t.string   "color"
    t.string   "material"
    t.integer  "quantity"
    t.text     "refund_policy"
    t.decimal  "price"
    t.decimal  "ship_df"
    t.string   "tipo_envio"
    t.integer  "peso"
    t.integer  "alto"
    t.integer  "largo"
    t.integer  "ancho"
    t.decimal  "price_estafeta"
    t.boolean  "status"
    t.string   "paypal_customer_token"
    t.string   "paypal_recurring_profile_token"
    t.string   "delivery_time"
    t.string   "url"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.string   "location"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "picture"
    t.boolean  "status",      :default => true
  end

  add_index "projects", ["status"], :name => "index_projects_on_status"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "rs_evaluations", :force => true do |t|
    t.string   "reputation_name"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.float    "value",           :default => 0.0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], :name => "index_rs_evaluations_on_reputation_name_and_source_and_target"
  add_index "rs_evaluations", ["reputation_name"], :name => "index_rs_evaluations_on_reputation_name"
  add_index "rs_evaluations", ["source_id", "source_type"], :name => "index_rs_evaluations_on_source_id_and_source_type"
  add_index "rs_evaluations", ["target_id", "target_type"], :name => "index_rs_evaluations_on_target_id_and_target_type"

  create_table "rs_reputation_messages", :force => true do |t|
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.float    "weight",      :default => 1.0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_receiver_id_and_sender"
  add_index "rs_reputation_messages", ["receiver_id"], :name => "index_rs_reputation_messages_on_receiver_id"
  add_index "rs_reputation_messages", ["sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_sender_id_and_sender_type"

  create_table "rs_reputations", :force => true do |t|
    t.string   "reputation_name"
    t.float    "value",           :default => 0.0
    t.string   "aggregated_by"
    t.integer  "target_id"
    t.string   "target_type"
    t.boolean  "active",          :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], :name => "index_rs_reputations_on_reputation_name_and_target"
  add_index "rs_reputations", ["reputation_name"], :name => "index_rs_reputations_on_reputation_name"
  add_index "rs_reputations", ["target_id", "target_type"], :name => "index_rs_reputations_on_target_id_and_target_type"

  create_table "ships", :force => true do |t|
    t.decimal  "ship_selected"
    t.string   "ship_name"
    t.integer  "product_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

  add_index "ships", ["product_id"], :name => "index_ships_on_product_id"

  create_table "sizes", :force => true do |t|
    t.string   "name"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sizes", ["product_id"], :name => "index_sizes_on_product_id"

  create_table "sizeships", :force => true do |t|
    t.integer  "product_id"
    t.integer  "size_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sizeships", ["product_id"], :name => "index_sizeships_on_product_id"
  add_index "sizeships", ["size_id"], :name => "index_sizeships_on_size_id"

  create_table "slides", :force => true do |t|
    t.string   "picture"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "slides", ["post_id"], :name => "index_slides_on_post_id"

  create_table "sources", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "name"
    t.integer  "micropost_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "taggings_count", :default => 0
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",   :null => false
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "username"
    t.string   "picture"
    t.string   "location"
    t.string   "website"
    t.text     "bio"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "nickname"
    t.boolean  "fb",                     :default => true
    t.boolean  "status",                 :default => true
    t.string   "cover"
    t.string   "biopic"
    t.string   "gender"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["fb"], :name => "index_users_on_facebook"
  add_index "users", ["gender"], :name => "index_users_on_gender"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["status"], :name => "index_users_on_status"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
