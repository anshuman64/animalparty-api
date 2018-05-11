class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string   :phone_number
      t.string   :email
      t.string   :political_party
      t.string   :firebase_uid,    null: false
      t.boolean  :is_banned,       null: false, default: false
      t.datetime :last_login,      null: false, default: Time.now
      t.timestamps
    end

    add_index :users, :phone_number, unique: true
    add_index :users, :email,        unique: true
    add_index :users, :firebase_uid, unique: true
  end
end
