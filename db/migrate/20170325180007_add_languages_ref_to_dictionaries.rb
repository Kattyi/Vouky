class AddLanguagesRefToDictionaries < ActiveRecord::Migration[5.0]
  def change
    add_reference :dictionaries, :language, foreign_key: true
  end
end
