class MakeCommentsCommentable < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :parent_comment_id
  end
end
