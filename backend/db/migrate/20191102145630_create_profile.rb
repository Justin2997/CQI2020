class CreateProfile < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles, id: :uuid do |t|
      t.integer :age, null: false
      t.integer :current_residence_years, null: false
      t.boolean :is_married, null: false
      t.integer :number_of_dependants, null: false
      t.boolean :graduated, null: false
      t.boolean :self_employed, null: false
      t.integer :years_of_job_stability, null: false

      t.integer :years_of_salary, null: false
      t.uuid :credit_rating, null: false
      t.integer :co_application_age, null: true
      t.integer :co_application_years_of_job_stability, null: true
      t.integer :co_application_yearly_salary, null: true
      t.integer :co_application_credit_rating, null: true
      t.integer :loan_term_in_years, null: false
      t.integer :loan_amount, null: false
      t.integer :property_total_cost, null: false
      t.uuid :area_classification, null: false
      t.boolean :approved, null: false

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
