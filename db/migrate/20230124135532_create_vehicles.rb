class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :nameplate
      t.string :brand
      t.string :vehicle_model
      t.integer :year_manufacture
      t.integer :maximum_load
      t.integer :status, default: 0
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
