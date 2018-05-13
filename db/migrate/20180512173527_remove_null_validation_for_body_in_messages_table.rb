class RemoveNullValidationForBodyInMessagesTable < ActiveRecord::Migration[5.1]
  def change
    change_column :messages, :body, :text, :null => true
  end
end
