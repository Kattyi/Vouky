class AddDictionaryRefToDictionariesCategories < ActiveRecord::Migration[5.0]
  def change
    add_reference :dictionaries_categories, :dictionary, foreign_key: true
  end
end
