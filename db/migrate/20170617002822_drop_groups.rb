class DropGroups < ActiveRecord::Migration[5.0]
  def change
    drop_table :groups, force: :cascade
  end
end
