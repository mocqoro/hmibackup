class RemoveUpdatedAndCreatedAtFromNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :created_at
    remove_column :notifications, :updated_at
  end
end
