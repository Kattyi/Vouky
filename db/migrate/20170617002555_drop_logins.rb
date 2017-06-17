class DropLogins < ActiveRecord::Migration[5.0]
  def change
    drop_table :logins
  end
end
