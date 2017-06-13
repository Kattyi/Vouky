class ChangeForeighKeyForDictionaries < ActiveRecord::Migration[5.0]
  def change
    rename_column :dictionaries, :languages_id, :language_id
  end
end
