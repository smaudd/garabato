class ChatVideo < ApplicationRecord
  has_many :chat_entries, -> { order(:position) }, dependent: :destroy

  has_one_attached :background
  has_one_attached :title_audio

  validates :slug,  presence: true, uniqueness: true,
                    format: { with: /\A[a-z0-9\-]+\z/, message: "solo letras minúsculas, números y guiones" }
  validates :title, presence: true

  accepts_nested_attributes_for :chat_entries,
    allow_destroy: true,
    reject_if: :all_blank
end
