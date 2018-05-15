class AddIsBlockedToConnectionsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :connections, :is_blocked, :boolean, null: false, default: false
  end
end
