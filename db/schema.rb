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

ActiveRecord::Schema.define(:version => 20121122085950) do

  create_table "ec2_instances", :force => true do |t|
    t.string   "instance_id"
    t.string   "description"
    t.integer  "rotate_count",   :default => 5
    t.integer  "interval_days",  :default => 3
    t.datetime "last_backup_at"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "ec2_instances", ["instance_id"], :name => "index_ec2_instances_on_instance_id", :unique => true

  create_table "ec2_snapshots", :force => true do |t|
    t.string   "snapshot_id"
    t.string   "description"
    t.string   "volume_id"
    t.integer  "ec2_instance_id"
    t.integer  "ec2_volume_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "ec2_snapshots", ["ec2_instance_id"], :name => "index_ec2_snapshots_on_ec2_instance_id"
  add_index "ec2_snapshots", ["ec2_volume_id"], :name => "index_ec2_snapshots_on_ec2_volume_id"
  add_index "ec2_snapshots", ["snapshot_id"], :name => "index_ec2_snapshots_on_snapshot_id", :unique => true
  add_index "ec2_snapshots", ["volume_id"], :name => "index_ec2_snapshots_on_volume_id"

  create_table "ec2_volumes", :force => true do |t|
    t.string   "volume_id"
    t.string   "description"
    t.integer  "rotate_count",   :default => 5
    t.integer  "interval_days",  :default => 3
    t.datetime "last_backup_at"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "ec2_volumes", ["volume_id"], :name => "index_ec2_volumes_on_volume_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.boolean  "is_admin"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
