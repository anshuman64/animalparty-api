class CreateConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :connections do |t|
      t.integer :blue_id, null: false, index: true
      t.integer :red_id,  null: false, index: true
      t.timestamps
    end

    add_column :users, :queued_at, :datetime
  end
end
