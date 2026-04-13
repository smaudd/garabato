class ChatVideo < ApplicationRecord
  has_many :chat_entries, -> { order(:id) }, dependent: :destroy

  has_one_attached :background
  has_one_attached :rendered_video

  validates :slug,             presence: true, uniqueness: true,
                               format: { with: /\A[a-z0-9\-]+\z/, message: "solo letras minúsculas, números y guiones" }
  validates :title,            presence: true
  validates :tts_model,        presence: true
  validates :voice,            presence: true
  validates :question_voice,   presence: true
  validates :question_display_ms, numericality: { only_integer: true, greater_than: 0 }

  accepts_nested_attributes_for :chat_entries,
    allow_destroy: true,
    reject_if: :all_blank
end
