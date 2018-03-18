class RemoveOptionsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :settings
  end
end