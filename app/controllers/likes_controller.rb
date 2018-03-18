class LikesController < ApplicationController
    # respond_to :js
    
    def like
      @user = current_user
      @post = Post.find(params[:post_id])
      @user.like!(@post)
      # send notifications to the posts owner
			@post.user.create_notification("#{current_user.username} liked your post, \"#{@post.name}\"", "#{current_user.username} liked your post, \"#{@post.name}\"")
      redirect_back fallback_location: post_path(@post)
    end
    
    def unlike
      @user = current_user
      @like = @user.likes.find_by_post_id(params[:post_id])
      @post = Post.find(params[:post_id])
      @like.destroy!
      redirect_back fallback_location: post_path(@post)
    end
end