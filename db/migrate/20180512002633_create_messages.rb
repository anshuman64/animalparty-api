class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text    :body,          null: false
      t.integer :author_id,     null: false, index: true
      t.integer :connection_id, null: false, index: true

      t.timestamps
    end

    execute "ALTER TABLE messages CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
  end
end
