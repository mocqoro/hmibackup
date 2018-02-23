class AddDeletedFlagToComments < ActiveRecord::Migration
  def change
    add_column :comments, :deleted, :boolean, default: false
    change_column_default :comments, :parent_comment_id, nil
  end
end
