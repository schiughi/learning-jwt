class AddProvisionalToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :provisional, :boolean, null: false, default: false
  end

  def down
    remove_column :users, :provisional, :boolean
  end
end
