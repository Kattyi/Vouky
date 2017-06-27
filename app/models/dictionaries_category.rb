class DictionariesCategory < ApplicationRecord
  belongs_to :dictionary
  belongs_to :category

  validates :category_id, presence: true
  validates :dictionary_id, presence: true
end