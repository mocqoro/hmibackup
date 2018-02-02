class SessionsController < ApplicationController
    def new
        
    end
    
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user and user.authenticate(params[:session][:password]) then
            session[:user_id] = user.id
            flash[:success] = "Loged in as #{user.username}"
            redirect_to user_path(user)
        else
            flash.now[:danger] = "Error"
            render 'new'            
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:notice] = "Loged out"
        redirect_to root_path
    end
end