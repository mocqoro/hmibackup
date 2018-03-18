class FollowsController < ApplicationController
    # respond_to :js
    
    def follow
        @user = current_user
        @followed_user = User.find(params[:followed_user_id])
        #puts '-----------------------------------------------------------------'
        #puts @user.username, 'is following', @followed_user.username
        #puts @user.id.to_s == params[:followed_user_id].to_s
        #puts '-----------------------------------------------------------------'
        @user.follow!(@followed_user)
        # send notifications to user
        @followed_user.create_notification("#{@user.username} is now following you", "#{@user.username} is now following you")
        redirect_back fallback_location: user_path(@followed_user)
    end
    
    def unfollow
        @user = current_user
        @follow = @user.followers.detect{|e| e.follower.id.to_i == params[:followed_user_id].to_i}
        #puts '-----------------------------------------------------------------'
        #puts @user.id, 'is unfollowing', params[:followed_user_id], '| deleting follow', @follow
        #puts @user.followers.any? {|e| e.follower.id.to_i == params[:followed_user_id].to_i}
        #puts @user.followers[0].follower.id.to_s
        #puts '|', @user.followers.length, '|'
        #puts '-----------------------------------------------------------------'
        @followed_user = User.find(params[:followed_user_id])
        @follow.destroy!
        redirect_back fallback_location: user_path(@followed_user)
    end
end