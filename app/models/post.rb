class Post < ActiveRecord::Base
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :users, through: :likes
    
    has_many :comments, as: :commentable
    
    serialize :tags, Array
end