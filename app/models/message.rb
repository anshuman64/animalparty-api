class Message < ApplicationRecord
  DEFAULT_LIMIT    = 20
  DEFAULT_START_AT = 1

  validates :author_id, presence: true
  validate  :validate_message_ownership

  belongs_to(:author, class_name: :User, foreign_key: :author_id, primary_key: :id)
  belongs_to(:connection, class_name: :Connection, foreign_key: :connection_id, primary_key: :id)
  has_one(:medium, class_name: :Medium, foreign_key: :message_id, primary_key: :id, dependent: :destroy)

  def self.query_direct_messages(limit, start_at, client_id, user_id)
    connection = Connection.find_connection(client_id, user_id)

    unless connection
      return []
    end

    most_recent_message = connection.messages.last

    limit    ||= DEFAULT_LIMIT
    start_at ||= (most_recent_message ? most_recent_message.id + 1 : DEFAULT_START_AT)

    connection.messages.where('id < ?', start_at).last(limit).reverse
  end


  def self.query_new_direct_messages(start_at, client_id, user_id)
    connection = Connection.find_connection(client_id, user_id)

    unless connection
      return []
    end

    most_recent_message = connection.messages.last

    start_at ||= (most_recent_message ? most_recent_message.id : DEFAULT_START_AT)

    connection.messages.where('id > ?', start_at).reverse
  end

  private

  def validate_message_ownership
    if self.connection.blank? && self.group.blank?
      self.errors.add :base, 'Require connection_id or group_id.'
    end
  end

end
