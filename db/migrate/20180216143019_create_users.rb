class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username         , null: false, default: ""
      t.string :password_digest  , null: false, default: ""
      t.boolean :admin           , null: false, default: false

      t.timestamps
    end
    add_index :users, :username,  unique: true
  end
end
