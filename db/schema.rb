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

ActiveRecord::Schema.define(version: 20161124060952) do

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "InnoDB free: 10240 kB; (`type_id`) REFER `library/types`(`id`)" do |t|
    t.string   "name"
    t.integer  "num"
    t.integer  "type_id"
    t.integer  "con",        default: 1
    t.integer  "bn",         default: 0
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["type_id"], name: "index_books_on_type_id", using: :btree
  end

  create_table "borrow", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "InnoDB free: 10240 kB" do |t|
    t.integer "ubn",     default: 0
    t.integer "book_id"
    t.integer "user_id"
  end

  create_table "cars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "InnoDB free: 10240 kB; (`product_id`) REFER `library/products`(`id`)" do |t|
    t.integer  "c_num"
    t.integer  "con",        default: 1
    t.integer  "product_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["product_id"], name: "index_cars_on_product_id", using: :btree
  end

  create_table "infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "InnoDB free: 10240 kB; (`book_id`) REFER `library/books`(`id`)" do |t|
    t.string   "author"
    t.string   "p_place"
    t.integer  "p_time"
    t.integer  "p_num"
    t.string   "language"
    t.integer  "format"
    t.string   "introduce"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_infos_on_book_id", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "InnoDB free: 10240 kB" do |t|
    t.string   "car_ids",                             default: "", null: false
    t.decimal  "cost",       precision: 10, scale: 2
    t.integer  "b_num"
    t.integer  "con",                                 default: 1
    t.integer  "pay_con",                             default: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "InnoDB free: 10240 kB" do |t|
    t.string   "p_name"
    t.decimal  "p_price",    precision: 10
    t.integer  "p_num"
    t.integer  "p_salNum"
    t.integer  "con",                       default: 1
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "InnoDB free: 10240 kB" do |t|
    t.string   "b_type"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "con",        default: 1
    t.index ["b_type"], name: "b_typeun", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "InnoDB free: 10240 kB" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "books", "types"
  add_foreign_key "cars", "products"
  add_foreign_key "infos", "books"
end
