class CreateOrderAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :order_addresses do |t|
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
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
