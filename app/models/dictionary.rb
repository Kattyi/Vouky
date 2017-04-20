class Dictionary < ApplicationRecord
  validates :word, presence: true
  validates :translation, presence: true
end