class AddColumnToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :sender_neighborhood, :string
    add_column :orders, :sender_number, :string
    add_column :orders, :sender_complement, :string
    add_column :orders, :recipient_neighborhood, :string
    add_column :orders, :recipient_number, :string
    add_column :orders, :recipient_complement, :string
  end
end
