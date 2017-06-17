class RemoveCategoryIdFromDictionaries < ActiveRecord::Migration[5.0]
  def change
    remove_column :dictionaries, :category_id, :integer
  end
end
