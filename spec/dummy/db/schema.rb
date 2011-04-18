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

ActiveRecord::Schema.define(:version => 20110418213427) do

  create_table "billing_activities", :force => true do |t|
    t.float    "amount"
    t.string   "message"
    t.integer  "subscription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_infos", :force => true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "email"
    t.string  "company"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "country"
    t.string  "phone_number"
    t.integer "subscription_id"
  end

  create_table "credit_cards", :force => true do |t|
    t.string  "expiration_date"
    t.string  "card_number"
    t.integer "subscription_id"
  end

  create_table "invoice_line_items", :force => true do |t|
    t.string  "description"
    t.date    "from"
    t.date    "to"
    t.float   "price"
    t.integer "invoice_id"
  end

  create_table "invoices", :force => true do |t|
    t.float    "total"
    t.integer  "invoice_number"
    t.integer  "billing_activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.float    "amount"
    t.integer  "subscription_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.string   "billing_period"
    t.integer  "subscription_id"
    t.float    "price"
    t.text     "dynamic_attributes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "billable_id"
    t.string   "billable_type"
    t.float    "balance"
    t.string   "status"
    t.integer  "customer_cim_id"
    t.integer  "customer_payment_profile_id"
    t.date     "billing_date"
    t.date     "invoiced_on"
    t.date     "overdue_on"
    t.boolean  "no_charge",                   :default => false
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.integer  "billing_activity_id"
    t.integer  "subscription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
