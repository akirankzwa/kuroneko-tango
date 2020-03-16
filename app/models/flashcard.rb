class Flashcard < ApplicationRecord
  has_one_attached :speech
  belongs_to :group
end
