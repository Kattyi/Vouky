class AddLanguagesRefToDictionaries < ActiveRecord::Migration[5.0]
  def change
    add_reference :dictionaries, :languages, foreign_key: true
  end
end
