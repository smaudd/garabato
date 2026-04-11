class Location < ApplicationRecord
  belongs_to :company
  has_and_belongs_to_many :posts

  validates :name, presence: true
  validates :address, presence: true
end
