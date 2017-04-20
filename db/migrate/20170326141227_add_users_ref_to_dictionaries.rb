class AddUsersRefToDictionaries < ActiveRecord::Migration[5.0]
  def change
    add_reference :dictionaries, :user, foreign_key: true
  end
end
