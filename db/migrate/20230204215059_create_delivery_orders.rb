class CreateDeliveryOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_orders do |t|
      t.string :code
      t.integer :deadline_hours
      t.decimal :delivery_fee
      t.decimal :km_price
      t.decimal :amount
      t.date :delivery_forecast
      t.date :delivery_date
      t.string :delivery_reason
      t.integer :status, default: 0
      t.integer :closure_status
      t.references :order, null: false, foreign_key: true
      t.references :mode_transport, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
