class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :password
      t.datetime :registred_date

      t.timestamps
    end
  end
end
