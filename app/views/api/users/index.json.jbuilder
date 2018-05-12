json.array! @users do |user|
  json.(user, :id, :firebase_uid, :phone_number, :email, :political_party, :is_banned, :last_login, :created_at, :updated_at)

  # friendship = Friendship.find_friendship(@client.id, user.id)
  # if friendship
  #   json.peek_message do
  #     message = friendship.messages.last
  #
  #     if message
  #       json.(message, :id, :body, :author_id, :friendship_id, :group_id, :post_id, :created_at, :updated_at)
  #     end
  #
  #   end
  # end
end
