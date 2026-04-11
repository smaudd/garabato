class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
