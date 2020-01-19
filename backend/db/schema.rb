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

ActiveRecord::Schema.define(version: 2019_11_02_151200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "area_classifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "number", null: false
    t.string "name", null: false
  end

  create_table "credit_ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "number", null: false
    t.string "name", null: false
  end

  create_table "profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "age", null: false
    t.integer "current_residence_years", null: false
    t.boolean "is_married", null: false
    t.integer "number_of_dependants", null: false
    t.boolean "graduated", null: false
    t.boolean "self_employed", null: false
    t.integer "years_of_job_stability", null: false
    t.integer "years_of_salary", null: false
    t.uuid "credit_rating", null: false
    t.integer "co_application_age"
    t.integer "co_application_years_of_job_stability"
    t.integer "co_application_yearly_salary"
    t.integer "co_application_credit_rating"
    t.integer "loan_term_in_years", null: false
    t.integer "loan_amount", null: false
    t.integer "property_total_cost", null: false
    t.uuid "area_classification", null: false
    t.boolean "approved", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

end
