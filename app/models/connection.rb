class Connection < ApplicationRecord
  validates :blue_id, :red_id, presence: true
  validates :blue_id, uniqueness: { scope: :red_id }

  belongs_to(:blue, class_name: :User, foreign_key: :blue_id, primary_key: :id)
  belongs_to(:red,  class_name: :User, foreign_key: :red_id,  primary_key: :id)

  has_many(:messages, class_name: :Message, foreign_key: :connection_id, primary_key: :id, dependent: :destroy)


  def self.find_connection(user1_id, user2_id)
    Connection.find_by_blue_id_and_red_id(user1_id, user2_id) || Connection.find_by_red_id_and_blue_id(user1_id, user2_id)
  end

  def self.query_connections(user)
    connections = user.reds_as_blue | user.blues_as_red

    sort_connections_by_recent_messages(user.id, connections)
  end

  private

  #TODO make this work
  def self.sort_connections_by_recent_messages(user_id, connections)
    connections.sort_by! do |connection|
      last_message = connection.messages.last

      if last_message
        last_message.created_at
      else
        connection.created_at
      end
    end

    connections.reverse
  end
end
