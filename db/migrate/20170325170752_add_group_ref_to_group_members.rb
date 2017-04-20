class AddGroupRefToGroupMembers < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups_members, :group, foreign_key: true
  end
end
