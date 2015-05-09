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

ActiveRecord::Schema.define(version: 20150505202805) do

  create_table "admins", force: :cascade do |t|
    t.string   "email"
    t.string   "club"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "name"
    t.integer  "goalMoney"
    t.integer  "clubMoney"
    t.integer  "currentMoney", default: 0
    t.date     "start_date"
    t.date     "end_date"
    t.text     "description"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "picture"
    t.integer  "club_id"
    t.integer  "completed",    default: 0
  end

  add_index "campaigns", ["club_id"], name: "index_campaigns_on_club_id"

  create_table "clubs", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "recipient_id"
    t.integer  "has_bank",        default: 0
  end

  create_table "pledges", force: :cascade do |t|
    t.float    "amount"
    t.integer  "status",           default: 1
    t.integer  "student_id"
    t.integer  "campaign_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "stripe_charge_id"
  end

  add_index "pledges", ["campaign_id", "created_at"], name: "index_pledges_on_campaign_id_and_created_at"
  add_index "pledges", ["campaign_id"], name: "index_pledges_on_campaign_id"
  add_index "pledges", ["student_id", "created_at"], name: "index_pledges_on_student_id_and_created_at"
  add_index "pledges", ["student_id"], name: "index_pledges_on_student_id"

  create_table "students", force: :cascade do |t|
    t.string   "netid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
