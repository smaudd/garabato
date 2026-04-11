class Company < ApplicationRecord
  has_many :locations, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :name, presence: true
end
