class CommentsController < ApplicationController
	before_action :set_comment, only: [:edit, :update, :destroy, :undelete]
	before_action :require_user
	before_action :require_same_user, only: [:edit, :update, :destroy]
	
    def new
	    @comment = Comment.new
    end
	
	def edit
	end
	
	def create
		@comment = Comment.new(comment_params)
		@comment.user = current_user
		@comment.post = Post.find(params[:comment][:post_id])
		@comment.parent_comment_id = params[:comment][:parent_comment]
		
		if @comment.save then
			# send notifications to the posts owner
			post.user.create_notification("#{current_user.username} commented on your post, \"#{@comment.post.name}\"", @comment.body.truncate(250)) 
			flash[:success] = "Comment was successfully created"
			redirect_to post_path(@comment.post)
		else
			render 'new'
		end
	end
	
	def destroy
		post = @comment.post
		@comment.deleted = true
		if @comment.save then
			flash[:success] = "Comment was successfully deleted"
			redirect_to post_path(post)
		else
			flash[:danger] = "Error deleting comment"
			redirect_to post_path(post)
		end
	end
	
	def undelete
		post = @comment.post
		@comment.deleted = false
		if @comment.save then
			flash[:success] = "Comment was successfully undeleted"
			redirect_to post_path(post)
		else
			flash[:danger] = "Error undeleted comment"
			redirect_to post_path(post)
		end
	end
	
	def update
		if @comment.update(comment_params) then
			flash[:success] = "Comment was successfully updated"
			redirect_to post_path(@comment.post)
		else
			render 'edit'
		end
	end
	
	private
		def set_comment
			@comment = Comment.find(params[:id])
		end
		
		def comment_params
			puts '----------------------------------------', params
			params.require(:comment).permit(:body)
		end
		
		def require_same_user
			if current_user != @comment.user and not current_user.admin? then
				flash[:danger] = "You can only edit or delete your own comments"
				redirect_to root_path
			end
		end
end