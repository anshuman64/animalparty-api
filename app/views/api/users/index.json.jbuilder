json.array! @users do |user|
  json.(user, :id, :firebase_uid, :phone_number, :email, :political_party, :is_banned, :queued_at, :last_login, :created_at, :updated_at)

  connection = Connection.find_connection(@client.id, user.id)
  if connection
    json.peek_message do
      message = connection.messages.last

      if message
        json.(message, :id, :body, :author_id, :connection_id, :created_at, :updated_at)
      end

    end
  end
end
