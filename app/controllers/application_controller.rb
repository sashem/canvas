#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def check_session
    cookie=params["cookie"]
    if User.where(:session_key=>cookie).exists?
      @user_id=User.where(:session_key=>cookie).first.id
      params[:user_id]=@user_id
      ##sign_in(User.find_by(:session_key=>cookie))
      @current_user=User.find_by(:session_key=>cookie)
      #p params[:my_user_id__]
      return
    end
    if !User.where(:session_key=>cookie).exists?
      response={msge:{type: 'warning', msg:"Debe iniciar sesión primero"}}
      respond_to do |format|
        format.html{ render json: response }
      end
    end
  end
  def check_admin
    if session[:user_role]!=0
      flash.now.alert = "Invalid email or password"
      redirect_to "/sessions/new"
    end
  end
end
