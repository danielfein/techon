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

ActiveRecord::Schema.define(version: 20150902065633) do

  create_table "credit_plans", force: :cascade do |t|
    t.integer  "price",         limit: 4
    t.string   "permalink",     limit: 255
    t.string   "name",          limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "award_credits", limit: 4
  end

  create_table "credits", force: :cascade do |t|
    t.integer  "uid",        limit: 4
    t.integer  "balance",    limit: 4, default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.string   "provider",            limit: 255
    t.string   "access_token",        limit: 255
    t.string   "access_token_secret", limit: 255
    t.string   "provider_id",         limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "payola_affiliates", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "email",      limit: 255
    t.integer  "percent",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payola_coupons", force: :cascade do |t|
    t.string   "code",        limit: 255
    t.integer  "percent_off", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                  default: true
  end

  create_table "payola_sales", force: :cascade do |t|
    t.string   "email",                limit: 255
    t.string   "guid",                 limit: 255
    t.integer  "product_id",           limit: 4
    t.string   "product_type",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                limit: 255
    t.string   "stripe_id",            limit: 255
    t.string   "stripe_token",         limit: 255
    t.string   "card_last4",           limit: 255
    t.date     "card_expiration"
    t.string   "card_type",            limit: 255
    t.text     "error",                limit: 65535
    t.integer  "amount",               limit: 4
    t.integer  "fee_amount",           limit: 4
    t.integer  "coupon_id",            limit: 4
    t.boolean  "opt_in"
    t.integer  "download_count",       limit: 4
    t.integer  "affiliate_id",         limit: 4
    t.text     "customer_address",     limit: 65535
    t.text     "business_address",     limit: 65535
    t.string   "stripe_customer_id",   limit: 255
    t.string   "currency",             limit: 255
    t.text     "signed_custom_fields", limit: 65535
    t.integer  "owner_id",             limit: 4
    t.string   "owner_type",           limit: 255
  end

  add_index "payola_sales", ["coupon_id"], name: "index_payola_sales_on_coupon_id", using: :btree
  add_index "payola_sales", ["email"], name: "index_payola_sales_on_email", using: :btree
  add_index "payola_sales", ["guid"], name: "index_payola_sales_on_guid", using: :btree
  add_index "payola_sales", ["owner_id", "owner_type"], name: "index_payola_sales_on_owner_id_and_owner_type", using: :btree
  add_index "payola_sales", ["product_id", "product_type"], name: "index_payola_sales_on_product", using: :btree
  add_index "payola_sales", ["stripe_customer_id"], name: "index_payola_sales_on_stripe_customer_id", using: :btree

  create_table "payola_stripe_webhooks", force: :cascade do |t|
    t.string   "stripe_id",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payola_subscriptions", force: :cascade do |t|
    t.string   "plan_type",            limit: 255
    t.integer  "plan_id",              limit: 4
    t.datetime "start"
    t.string   "status",               limit: 255
    t.string   "owner_type",           limit: 255
    t.integer  "owner_id",             limit: 4
    t.string   "stripe_customer_id",   limit: 255
    t.boolean  "cancel_at_period_end"
    t.datetime "current_period_start"
    t.datetime "current_period_end"
    t.datetime "ended_at"
    t.datetime "trial_start"
    t.datetime "trial_end"
    t.datetime "canceled_at"
    t.integer  "quantity",             limit: 4
    t.string   "stripe_id",            limit: 255
    t.string   "stripe_token",         limit: 255
    t.string   "card_last4",           limit: 255
    t.date     "card_expiration"
    t.string   "card_type",            limit: 255
    t.text     "error",                limit: 65535
    t.string   "state",                limit: 255
    t.string   "email",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency",             limit: 255
    t.integer  "amount",               limit: 4
    t.string   "guid",                 limit: 255
    t.string   "stripe_status",        limit: 255
    t.integer  "affiliate_id",         limit: 4
    t.string   "coupon",               limit: 255
    t.text     "signed_custom_fields", limit: 65535
    t.text     "customer_address",     limit: 65535
    t.text     "business_address",     limit: 65535
    t.integer  "setup_fee",            limit: 4
  end

  add_index "payola_subscriptions", ["guid"], name: "index_payola_subscriptions_on_guid", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "price",       limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider",    limit: 255
    t.string   "url",         limit: 255
    t.string   "pretty_url",  limit: 255
    t.integer  "owner_uid",   limit: 4
    t.integer  "is_active",   limit: 4,   default: 1
    t.string   "provider_id", limit: 255
    t.string   "cover_photo", limit: 255
    t.string   "profile_pic", limit: 255
  end

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "sender_uid",     limit: 4
    t.integer  "recipient_uid",  limit: 4
    t.integer  "payment_amount", limit: 4
    t.datetime "date_occured"
    t.string   "provider_type",  limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "product_id",     limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
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
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "screen_name",            limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "website",                limit: 255
    t.string   "twitter_link",           limit: 255
    t.string   "description",            limit: 255
    t.string   "facebook_token",         limit: 255
    t.string   "instagram_token",        limit: 255
    t.string   "twitter_token",          limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "validate_facebooks", force: :cascade do |t|
    t.integer  "uid",        limit: 4
    t.datetime "time"
    t.integer  "before",     limit: 4
    t.string   "url",        limit: 255
    t.integer  "url_id",     limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "awarded",    limit: 4,   default: 0
    t.integer  "product_id", limit: 4
    t.integer  "balance",    limit: 4
  end

  create_table "validate_instagrams", force: :cascade do |t|
    t.integer  "uid",        limit: 4
    t.datetime "time"
    t.integer  "before",     limit: 4
    t.string   "username",   limit: 255
    t.integer  "url_id",     limit: 4
    t.integer  "awarded",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "product_id", limit: 4
    t.integer  "balance",    limit: 4
  end

  create_table "validate_twitters", force: :cascade do |t|
    t.integer  "uid",        limit: 4
    t.datetime "time"
    t.integer  "before",     limit: 4
    t.string   "url",        limit: 255
    t.integer  "url_id",     limit: 4
    t.integer  "awarded",    limit: 4,   default: 0
    t.integer  "product_id", limit: 4
    t.string   "username",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "balance",    limit: 4
  end

  add_foreign_key "identities", "users"
end
