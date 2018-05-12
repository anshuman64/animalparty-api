class Connection < ApplicationRecord
  validates :blue_id, :red_id, presence: true
  validates :blue_id, uniqueness: { scope: :red_id }

  belongs_to(:blue, class_name: :User, foreign_key: :blue_id, primary_key: :id)
  belongs_to(:red,  class_name: :User, foreign_key: :red_id,  primary_key: :id)

  # has_many(:messages, class_name: :Message, foreign_key: :connection_id, primary_key: :id, dependent: :destroy)

  def self.query_connections(user)
    connections = user.reds_as_blue | user.blues_as_red

    # sort_connections_by_recent_messages(user.id, connections)
  end

  private

  # def self.sort_connections_by_recent_messages(user_id, connections)
  #   connections.sort_by! do |connection|
  #     connectionship = Connection.find_connection(user_id, connection.id)
  #
  #     last_message = connectionship.messages.last
  #     if last_message
  #       last_message.created_at
  #     else
  #       connectionship.created_at
  #     end
  #   end
  #
  #   connections.reverse
  # end
end
