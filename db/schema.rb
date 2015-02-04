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

ActiveRecord::Schema.define(version: 20130826154354) do

  create_table "categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "menu_label"
    t.boolean  "is_koopje",      default: false
    t.boolean  "alle_veilingen", default: false
    t.boolean  "alle_koopjes",   default: false
    t.integer  "position"
  end

  create_table "category_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "category_hierarchies", ["ancestor_id", "descendant_id"], name: "index_category_hierarchies_on_ancestor_id_and_descendant_id", unique: true
  add_index "category_hierarchies", ["descendant_id"], name: "index_category_hierarchies_on_descendant_id"

  create_table "category_translations", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "locale"
    t.string   "title"
    t.string   "menu_label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id"

  create_table "payment_notifications", force: :cascade do |t|
    t.text     "params"
    t.integer  "order_id"
    t.integer  "login_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_transactions", force: :cascade do |t|
    t.text     "description"
    t.integer  "amount"
    t.string   "client"
    t.string   "client_email"
    t.string   "payment"
    t.text     "paymill_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "login_id"
    t.integer  "order_id"
    t.integer  "winnaar_id"
    t.integer  "koper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "bedrag",     precision: 8, scale: 2
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "pic"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
  end

  create_table "product_pictures", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "picture_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

end
