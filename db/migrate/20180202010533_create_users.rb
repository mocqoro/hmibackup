class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.timestamps
      t.string :password_digest
      t.integer :admin, default: 0
    end
  end
end