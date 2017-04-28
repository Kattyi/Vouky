class AddLanguagesRefToGroups < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups, :languages, foreign_key: true
  end
end
