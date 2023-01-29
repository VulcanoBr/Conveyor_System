class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.integer :start_distance
      t.integer :final_distance
      t.integer :deadline_hours
      t.references :mode_transport, null: false, foreign_key: true

      t.timestamps
    end
  end
end
