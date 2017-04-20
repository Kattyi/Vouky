class CreateLogins < ActiveRecord::Migration[5.0]
  def change
    create_table :logins do |t|
      t.datetime :last_login
      t.text :browser_type
      t.text :ip_address
    end
  end
end
