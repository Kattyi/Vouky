class AddCategoryRefToDictionariesCategories < ActiveRecord::Migration[5.0]
  def change
    add_reference :dictionaries_categories, :category, foreign_key: true
  end
end
