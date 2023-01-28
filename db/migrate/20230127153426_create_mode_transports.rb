class CreateModeTransports < ActiveRecord::Migration[7.0]
  def change
    create_table :mode_transports do |t|
      t.string :name
      t.integer :minimum_distance
      t.integer :maximum_distance
      t.integer :minimum_weight
      t.integer :maximum_weight
      t.decimal :delivery_fee
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
