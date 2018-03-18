class User < ActiveRecord::Base
    has_many :posts, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_posts, :through => :likes, :source => :post
    
    has_many :followers, :class_name => 'Follow', :foreign_key => 'user_id'
    has_many :following, :class_name => 'Follow', :foreign_key => 'follower_id'
    
    has_many :comments, as: :commentable
    
    before_save {self.email = email.downcase}
    validates :username, presence: true, uniqueness: {case_sensitive: false},
                length: {minimum: 3, maximum: 25}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: {case_sensitive: false},
                length: {maximum: 105}, format: {with: VALID_EMAIL_REGEX}
    has_secure_password
    
    # creates a new like row with post_id and user_id
    def like!(post)
        self.likes.create!(post_id: post.id)
    end
    
    # destroys a like with matching post_id and user_id
    def unlike!(post)
        like = self.likes.find_by_post_id(post.id)
        like.destroy!
    end
    
    # returns true if a post is liked by user
    def like?(post)
        self.likes.find_by_post_id(post.id)
    end
    
    # creates a new follow row with followed_user_id and user_id
    def follow!(follower)
        #puts '-----------------------------------------------------------------'
        #puts follower.username
        #puts self.username
        #puts '-----------------------------------------------------------------'
        self.followers.create!(follower_id: follower.id)
    end
    
    # destroys a follow with matching followed_user_id and user_id
    def unfollow!(follower)
        follow = self.followers.find_by_post_id(follower.id)
        follow.destroy!
    end
    
    # returns true if a follower is followed by user
    def follow?(follower)
        follower.following.any? {|e| e.user.id == self.id}
    end
    
    # creates a notification with a user_id of this user (self)
    def create_notification(title, body)
        @notification = Notification.new
		@notification.user = self
		@notification.title = title
		@notification.body = body
		
		# puts '--------------------------------', @notification.user_id, @notification.body
		
		@notification.save
    end
end