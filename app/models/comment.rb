class Comment < ActiveRecord::Base
  #belongs_to :post
  belongs_to :commentable, polymorphic: true
  #belongs_to :parent_comment
  belongs_to :user
  
  has_many :comments, as: :commentable
  
  def head_parent
    parent = self
    while parent.commentable_type == "Comment" do
      parent = parent.commentable
    end
    puts '----------------------------------------------------------', parent, parent.id, parent.commentable_type
    return parent.commentable
  end
end