class CreateCreditRating < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_ratings, id: :uuid do |t|
      t.integer :number, null: false
      t.string :name, null: false
    end
  end
end
