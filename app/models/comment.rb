class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :parent_comment
  belongs_to :user
  
  def get_parent_comment
    Comment.find(self.parent_comment_id)
  end
end