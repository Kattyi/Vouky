class CreateDictionary < ActiveRecord::Migration[5.0]
  def change
    create_table :dictionaries do |t|
      t.text :word
      t.text :translation
      t.text :note

      t.timestamps
    end
  end
end
