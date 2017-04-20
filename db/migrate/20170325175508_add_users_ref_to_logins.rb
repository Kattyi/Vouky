class AddUsersRefToLogins < ActiveRecord::Migration[5.0]
  def change
    add_reference :logins, :user, foreign_key: true
  end
end
