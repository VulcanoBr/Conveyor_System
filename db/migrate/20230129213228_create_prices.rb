class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.integer :start_weight
      t.integer :final_weight
      t.decimal :km_price
      t.references :mode_transport, null: false, foreign_key: true

      t.timestamps
    end
  end
end
