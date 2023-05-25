class ChangeColumnIdentificationToStringInOrders < ActiveRecord::Migration[7.0]
  def up
    change_column :orders, :sender_identification, :string
    change_column :orders, :recipient_identification, :string
  end

  def down
    change_column :orders, :sender_identification, :integer
    change_column :orders, :recipient_identification, :integer
  end
end
