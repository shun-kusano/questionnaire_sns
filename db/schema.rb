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

ActiveRecord::Schema.define(version: 20171221132610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ansnotifications", force: :cascade do |t|
    t.boolean "answered", default: false
    t.bigint "user_id"
    t.bigint "questionnaire_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id"], name: "index_ansnotifications_on_questionnaire_id"
    t.index ["user_id"], name: "index_ansnotifications_on_user_id"
  end

  create_table "answeras", force: :cascade do |t|
    t.bigint "questionnaire_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id", "user_id"], name: "index_answeras_on_questionnaire_id_and_user_id", unique: true
    t.index ["questionnaire_id"], name: "index_answeras_on_questionnaire_id"
    t.index ["user_id"], name: "index_answeras_on_user_id"
  end

  create_table "answerbs", force: :cascade do |t|
    t.bigint "questionnaire_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id", "user_id"], name: "index_answerbs_on_questionnaire_id_and_user_id", unique: true
    t.index ["questionnaire_id"], name: "index_answerbs_on_questionnaire_id"
    t.index ["user_id"], name: "index_answerbs_on_user_id"
  end

  create_table "cmtnotifications", force: :cascade do |t|
    t.boolean "read", default: false
    t.bigint "user_id"
    t.bigint "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_cmtnotifications_on_comment_id"
    t.index ["user_id"], name: "index_cmtnotifications_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "questionnaire_id"
    t.index ["questionnaire_id"], name: "index_comments_on_questionnaire_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.text "body"
    t.string "qimage"
    t.datetime "date_by"
    t.text "optiona_body"
    t.string "optiona_image"
    t.text "optionb_body"
    t.string "optionb_image"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questionnaires_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "admin", default: false
    t.string "uid", default: "", null: false
    t.string "provider", default: "", null: false
    t.string "image_url"
    t.string "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "ansnotifications", "questionnaires"
  add_foreign_key "ansnotifications", "users"
  add_foreign_key "answeras", "questionnaires"
  add_foreign_key "answeras", "users"
  add_foreign_key "answerbs", "questionnaires"
  add_foreign_key "answerbs", "users"
  add_foreign_key "cmtnotifications", "comments"
  add_foreign_key "cmtnotifications", "users"
  add_foreign_key "comments", "questionnaires"
  add_foreign_key "comments", "users"
  add_foreign_key "questionnaires", "users"
end
