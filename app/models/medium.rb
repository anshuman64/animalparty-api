class Medium < ApplicationRecord
  validates :owner_id, :aws_path, :mime_type, :height, :width, presence: true

  belongs_to(:owner, class_name: :User, foreign_key: :owner_id, primary_key: :id)
  belongs_to(:message, class_name: :Message, foreign_key: :message_id, primary_key: :id)
end
