class CreateAreaClassification < ActiveRecord::Migration[5.2]
  def change
    create_table :area_classifications, id: :uuid do |t|
      t.integer :number, null: false
      t.string :name, null: false
    end
  end
end
