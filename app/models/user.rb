class User < ApplicationRecord
  VALID_PARTIES = ['DEMOCRAT', 'REPUBLICAN']

  validates :firebase_uid, :email, :phone_number, uniqueness: { allow_blank: true, case_sensitive: false }
  validates :political_party, inclusion: { in: VALID_PARTIES, allow_blank: true }

  has_many(:connections_as_blue, class_name: :Connection, foreign_key: :blue_id, primary_key: :id, dependent: :destroy)
  has_many(:connections_as_red, class_name: :Connection, foreign_key: :red_id, primary_key: :id, dependent: :destroy)
  has_many(:reds_as_blue, through: :connections_as_blue, source: :red)
  has_many(:blues_as_red, through: :connections_as_red, source: :blue)

  has_many(:messages, class_name: :Message, foreign_key: :author_id, primary_key: :id, dependent: :destroy)

  has_many(:media, class_name: :Medium, foreign_key: :owner_id, primary_key: :id, dependent: :destroy)
end
