class SessionsController < ApplicationController
    def new
    end
    
    def create
      user = User.where(:username=>params[:username],:password=>params[:password].encrypt).first
      if user
        session[:user_id]=user.id
        session[:user_role]=user.role
        #redirect_to root_url, :notice => "Logged in!"
        redirect_to "/users"
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    end
    
    def show
      
    end
    
    def destroy
      reset_session
      session[:user_id]
      session[:user_role] = nil
      render "new"
    end
end