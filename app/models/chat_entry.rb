class ChatEntry < ApplicationRecord
  belongs_to :chat_video

  validates :username, presence: true
  validates :question, presence: true
  validates :answer,   presence: true
end
