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

ActiveRecord::Schema.define(version: 20151112041742) do

  create_table "carts", force: :cascade do |t|
    t.string   "email_paypal",        limit: 255
    t.integer  "price",               limit: 4
    t.string   "transaction_id",      limit: 255
    t.datetime "purchased_at"
    t.text     "notification_params", limit: 65535
    t.string   "status",              limit: 255
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "flights", force: :cascade do |t|
    t.string   "code",                limit: 255
    t.integer  "status",              limit: 4,   default: 0,  null: false
    t.date     "start_time"
    t.date     "end_time"
    t.integer  "start_place_id",      limit: 4
    t.integer  "end_place_id",        limit: 4
    t.integer  "cooldown_date",       limit: 4,   default: 1,  null: false
    t.integer  "number_ticket_1",     limit: 4,   default: 50, null: false
    t.integer  "number_ticket_2",     limit: 4,   default: 50, null: false
    t.integer  "number_ticket_3",     limit: 4,   default: 50, null: false
    t.integer  "number_ticket_other", limit: 4,   default: 0,  null: false
    t.integer  "price_ticket_1",      limit: 4,   default: 10, null: false
    t.integer  "price_ticket_2",      limit: 4,   default: 10, null: false
    t.integer  "price_ticket_3",      limit: 4,   default: 10, null: false
    t.integer  "price_ticket_other",  limit: 4,   default: 0,  null: false
    t.integer  "plane_id",            limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "flights", ["plane_id"], name: "index_flights_on_plane_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "city",       limit: 255
    t.string   "country",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "planes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.integer  "status",     limit: 4,   default: 0, null: false
    t.integer  "company_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "planes", ["company_id"], name: "index_planes_on_company_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.string   "location",   limit: 255
    t.integer  "level",      limit: 4,   default: 0, null: false
    t.integer  "status",     limit: 4,   default: 0, null: false
    t.integer  "price",      limit: 4,   default: 0, null: false
    t.integer  "plane_id",   limit: 4
    t.integer  "flight_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "cart_id",    limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "tickets", ["cart_id"], name: "index_tickets_on_cart_id", using: :btree
  add_index "tickets", ["flight_id"], name: "index_tickets_on_flight_id", using: :btree
  add_index "tickets", ["plane_id"], name: "index_tickets_on_plane_id", using: :btree
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "name",                   limit: 255
    t.string   "address",                limit: 255
    t.string   "passport",               limit: 255
    t.string   "credit_card",            limit: 255
    t.integer  "gender",                 limit: 4,   default: 0,  null: false
    t.integer  "badge",                  limit: 4,   default: 0,  null: false
    t.date     "birthday"
    t.integer  "role",                   limit: 4,   default: 0,  null: false
    t.string   "image",                  limit: 255
    t.string   "uid",                    limit: 255
    t.string   "provider",               limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "carts", "users"
  add_foreign_key "flights", "planes"
  add_foreign_key "planes", "companies"
  add_foreign_key "tickets", "carts"
  add_foreign_key "tickets", "flights"
  add_foreign_key "tickets", "planes"
  add_foreign_key "tickets", "users"
end
