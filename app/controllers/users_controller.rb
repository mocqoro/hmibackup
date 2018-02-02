class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	before_action :require_admin, only: [:destroy]
	
    def index
		@users = User.all
    end
    
    def new
       @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save then
            session[:user_id] = @user.id
           flash[:success] = "Welcome to Alphe Blog #{@user.username}!"
           redirect_to user_path(@user)
        else
           render 'new' 
        end
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params) then
            flash[:success] = "Yout account was successfully updated"
            redirect_to articles_path
        else
           render 'edit' 
        end
    end
    
    def show
    end
    
    def destroy
        @user.destroy
        flash[:danger] = "User and all theirs articles have been destroyed"
        redirect_to users_path
    end
    
    private
    def user_params
       params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def require_same_user
        if current_user != @user and not current_user.admin? then
            flash[:danger] = "You can only edit your own account"
			redirect_to root_path
        end
    end
    
    def require_admin
        if logged_in? and not current_user.admin? then
            flash[:danger] = "Only admins can preform that acction"
            redirect_to root_path
        end
    end
end