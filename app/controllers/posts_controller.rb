class PostsController < ApplicationController
	before_action :set_post, only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	
	def index
		@posts = Post.all
	end
	
	def new
		@post = Post.new
	end
	
	def edit
	end
	
	def create
		@post = Post.new(post_params)
		@post.user = current_user
		
		if @post.save then
			flash[:success] = "Post was successfully created"
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end
	
	def show
	end
	
	def destroy
		@post.destroy
		flash[:success] = "Post was successfully deleted"
		redirect_to posts_path
	end
	
	def update
		@post = Post.find(params[:id])
		@post.tags = params[:post][:tags].split(',')
		@post.tags.collect(&:strip!)
		@post.tags.reject!(&:empty?)
		if @post.update(post_params) then
			flash[:success] = "Post was successfully updated"
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end
	
	private
		def set_post
			@post = Post.find(params[:id])
		end
		
		def post_params
			params.require(:post).permit(:name, :body)
		end
		
		def require_same_user
			if current_user != @post.user and not current_user.admin? then
				flash[:danger] = "You can only edit or delete your own posts"
				redirect_to root_path
			end
		end
end