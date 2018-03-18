class MakeCommentsPolymorphic < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :post_id
    change_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
    end
  end
end
