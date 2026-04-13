class ChatEntry < ApplicationRecord
  belongs_to :chat_video

  has_one_attached :background

  validates :username, presence: true
  validates :question, presence: true
  validates :answer,   presence: true
end
