class AddLanguagesRefToGroups < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups, :language, foreign_key: true
  end
end
