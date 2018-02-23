class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy, :notifications, :read_all_notifications, :delete_all_notifications]
	before_action :require_same_user, only: [:edit, :update, :destroy, :notifications, :read_all_notifications, :delete_all_notifications]
	before_action :require_admin, only: [:destroy]
	
    def index
		@users = User.all
    end
    
    def notifications
        @notifications = Notification.where(:user => @user)
    end
    
    def new
       @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save then
            session[:user_id] = @user.id
            flash[:success] = "Welcome, #{@user.username}!"
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
            redirect_to user_path(@user)
        else
            render 'edit' 
        end
    end
    
    def show
    end
    
    def destroy
        @user.destroy
        flash[:danger] = "User and all theirs users have been destroyed"
        redirect_to users_path
    end
    
    def read_all_notifications
        @notifications = Notification.where(:user => @user)
        @notifications.each do |notification|
            notification.read = true
            notification.save
        end
        redirect_to :back
    end
    
    def delete_all_notifications
        @notifications = Notification.where(:user => @user)
        @notifications.each do |notification|
            notification.destroy
        end
        redirect_to :back
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :description)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def require_same_user
        if not logged_in? then
            flash[:danger] = "You can only edit your own account"
			redirect_to root_path
        elsif current_user != @user and current_user.admin < @user.admin then
            flash[:danger] = "You can only edit your own account"
			redirect_to root_path
        end
    end
    
    def require_admin
        if logged_in? and not current_user.admin > 0 then
            flash[:danger] = "Only admins can preform that acction"
            redirect_to root_path
        end
    end
end