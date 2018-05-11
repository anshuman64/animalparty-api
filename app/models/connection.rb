class Connection < ApplicationRecord
  validates :blue_id, :red_id, presence: true
  validates :blue_id, uniqueness: { scope: :red_id }

  belongs_to(:blue, class_name: :User, foreign_key: :blue_id, primary_key: :id)
  belongs_to(:red,  class_name: :User, foreign_key: :red_id,  primary_key: :id)

  # has_many(:messages, class_name: :Message, foreign_key: :friendship_id, primary_key: :id, dependent: :destroy)
end
