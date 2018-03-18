class CreatePost < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.text :body
      t.timestamps
      t.text :tags
    end
  end
end
