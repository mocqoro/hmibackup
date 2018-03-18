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
		if not params[:comment][:parent_comment] then
			@comment.commentable = Post.find(params[:comment][:post_id])
		else
			@comment.commentable = Comment.find(params[:comment][:parent_comment])
		end
		
		puts '----------------------------------------------------', @comment.commentable.id
		
		if @comment.save then
			# send notifications to the posts owner
			if @comment.commentable_type == "Post" then
				@comment.commentable.user.create_notification("#{current_user.username} commented on your post, \"#{@comment.commentable.name}\"", @comment.body.truncate(250)) 
				flash[:success] = "Comment was successfully created"
				redirect_to post_path(@comment.commentable)
			else
				flash[:success] = "Comment was successfully created"
				redirect_to post_path(@comment.head_parent)
			end
		else
			render 'new'
		end
	end
	
	def destroy
		commentable = @comment.commentable
		@comment.deleted = true
		if @comment.save then
			flash[:success] = "Comment was successfully deleted"
			if @comment.commentable_type == "Post" then
				redirect_to post_path(commentable)
			else
				redirect_to post_path(@comment.head_parent)
			end
		else
			flash[:danger] = "Error deleting comment"
			redirect_to post_path(commentable)
		end
	end
	
	def undelete
		commentable = @comment.commentable
		@comment.deleted = false
		if @comment.save then
			flash[:success] = "Comment was successfully undeleted"
			if @comment.commentable_type == "Post" then
				redirect_to post_path(commentable)
			else
				redirect_to post_path(@comment.head_parent)
			end
		else
			flash[:danger] = "Error undeleted comment"
			redirect_to post_path(commentable)
		end
	end
	
	def update
		if @comment.update(comment_params) then
			flash[:success] = "Comment was successfully updated"
			if @comment.commentable_type == "Post" then
				redirect_to post_path(commentable)
			else
				redirect_to post_path(@comment.head_parent)
			end
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