class DictionariesCategories < ApplicationRecord
  belongs_to :dictionary
  belongs_to :category
end