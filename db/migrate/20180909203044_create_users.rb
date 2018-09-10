class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :token
      t.string :uid
    end
    add_index :users, :email
    add_index :users, :uid
  end
end
