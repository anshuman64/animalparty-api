class User < ApplicationRecord
  validates :firebase_uid, :username, :email, :phone_number, uniqueness: { allow_blank: true, case_sensitive: false }

  has_many(:blocks_as_blocker, class_name: :Block, foreign_key: :blocker_id, primary_key: :id, dependent: :destroy)
  has_many(:blocks_as_blockee, class_name: :Block, foreign_key: :blockee_id, primary_key: :id, dependent: :destroy)
  has_many(:blockers, through: :blocks_as_blockee, source: :blocker)
  has_many(:blockees, through: :blocks_as_blocker, source: :blockee)

  has_many(:friendships_as_requester, class_name: :Friendship, foreign_key: :requester_id, primary_key: :id, dependent: :destroy)
  has_many(:friendships_as_requestee, class_name: :Friendship, foreign_key: :requestee_id, primary_key: :id, dependent: :destroy)
  has_many(:friends_as_requester, through: :friendships_as_requester, source: :requestee)
  has_many(:friends_as_requestee, through: :friendships_as_requestee, source: :requester)

  has_many(:messages, class_name: :Message, foreign_key: :author_id, primary_key: :id, dependent: :destroy)

  has_many(:media, class_name: :Medium, foreign_key: :owner_id, primary_key: :id, dependent: :destroy)
end
