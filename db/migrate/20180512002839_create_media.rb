class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.integer :owner_id,    null: false, index: true
      t.string  :aws_path,    null: false
      t.string  :mime_type,   null: false
      t.integer :message_id,               index: true
      t.integer :height,      null: false
      t.integer :width,       null: false
      t.timestamps
    end
  end
end
