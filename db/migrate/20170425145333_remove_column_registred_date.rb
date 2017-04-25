class RemoveColumnRegistredDate < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :registred_date
  end
end
