class Flashcard < ApplicationRecord
  has_one_attached :speech
  belongs_to :group
  validates :term, uniqueness: true
end
