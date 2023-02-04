class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.string :product_code
      t.integer :height
      t.integer :width
      t.integer :depth
      t.integer :weight
      t.string :description
      t.integer :distance
      t.string :sender_name
      t.integer :sender_identification
      t.string :sender_email
      t.string :sender_phone
      t.string :sender_address
      t.string :sender_city
      t.string :sender_state
      t.string :sender_zipcode
      t.string :recipient_name
      t.integer :recipient_identification
      t.string :recipient_email
      t.string :recipient_phone
      t.string :recipient_address
      t.string :recipient_city
      t.string :recipient_state
      t.string :recipient_zipcode
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
