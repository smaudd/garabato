class Post < ApplicationRecord
  belongs_to :company
  belongs_to :category, optional: true
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :tags

  validates :title, presence: true
end
