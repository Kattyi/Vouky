class AddCategoriesRefToDictionaries < ActiveRecord::Migration[5.0]
  def change
    add_reference :dictionaries, :category, foreign_key: true
  end
end
