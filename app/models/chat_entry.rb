class ChatEntry < ApplicationRecord
  belongs_to :chat_video

  has_one_attached :background
  has_one_attached :question_audio
  has_one_attached :answer_audio

  validates :username, presence: true
  validates :question,  presence: true
  validates :answer,    presence: true
  validates :position,  numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
