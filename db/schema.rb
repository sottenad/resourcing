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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140612014708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "title"
    t.string   "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "allocations", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "hours_per_day"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.decimal  "total_hours"
  end

  create_table "project_statuses", force: true do |t|
    t.string "title"
  end

  create_table "projects", force: true do |t|
    t.string  "title"
    t.string  "number"
    t.integer "budget_currency"
    t.integer "budget_hours"
    t.integer "user_id"
    t.integer "project_status_id"
    t.integer "account_id"
  end

  add_index "projects", ["project_status_id"], name: "index_projects_on_project_status_id", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "subscription_types", force: true do |t|
    t.string   "title"
    t.integer  "price"
    t.string   "stripe_plan_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "subscription_type_id"
    t.integer  "user_id"
    t.string   "stripe_subscription_id"
    t.integer  "trial_start"
    t.integer  "trial_end"
    t.boolean  "active"
    t.boolean  "is_free"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", unique: true, using: :btree

  create_table "user_groups", force: true do |t|
    t.string  "title"
    t.integer "account_id"
    t.integer "rate"
  end

  create_table "user_statuses", force: true do |t|
    t.string "title"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_group_id"
    t.integer  "user_status_id"
    t.integer  "subscription_id"
    t.string   "stripe_customer_id"
    t.integer  "account_id"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["subscription_id"], name: "index_users_on_subscription_id", using: :btree
  add_index "users", ["user_group_id"], name: "index_users_on_user_group_id", using: :btree
  add_index "users", ["user_status_id"], name: "index_users_on_user_status_id", using: :btree

end
