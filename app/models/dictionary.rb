class Dictionary < ApplicationRecord
  has_many :categories
  has_many :dictionaries_categories, dependent: :destroy
  accepts_nested_attributes_for :dictionaries_categories
end