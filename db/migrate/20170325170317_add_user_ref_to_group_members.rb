class AddUserRefToGroupMembers < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups_members, :user, foreign_key: true
  end
end
