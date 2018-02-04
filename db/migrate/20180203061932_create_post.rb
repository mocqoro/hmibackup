class CreatePost < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :body
      t.timestamps
      t.text :tags
    end
  end
end
