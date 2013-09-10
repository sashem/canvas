#encoding: utf-8
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :set_access_control_headers
  before_filter :check_session, :except => [:login,:show,:index,:create,:update,:new]
  
  def index
    @users = User.all
  end

  def login
    user = params["user"]
    user_finded=User.where(username: user["username"],password: user["password"].encrypt).first
    if user_finded
      key=SecureRandom.base64
      cookie=user_finded.id.to_s.encrypt(:symmetric, :password=>key)+" "+key
      user_finded.session_key=cookie
      if user_finded.save and user_finded
        response={msge:{type: 'success', msg:"Gracias por iniciar sesión"},cookie:cookie}
      end
      
    end
    if !user_finded
        response={msge:{type: 'warning', msg:"Usuario o contraseña incorrectos"}}
    end
    respond_to do |format|
        format.html{ render json: response }
    end
  end
  
  def fetch
    p User.where(:session_key=>params["cookie"]).first.dato
    respond_to do |format|
        format.html{ render json: User.where(:session_key=>params["cookie"]).first}
    end  
  end
  
  def update_datos
    parametros=params["user"]
    user=User.where(:session_key=>params["cookie"]).first
    user_updated=user.update(user_params)
    response={msge:{type: 'success', msg:"Sus Datos han sido actualizados"}}
    respond_to do |format|
        format.json{ render json: response }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.password=@user.password.encrypt
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def set_access_control_headers 
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Max-Age'] = '6000'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :role, :session_key, dato_attributes:[:nombre, :apellido, :mail, :edad, :user_id] )
    end
end
