#encoding: utf-8
class ProyectosController < ApplicationController
  before_action :set_proyecto, only: [:delete, :update_proyecto]
  before_action :check_session
  before_action :check_owner, only: [:delete, :update_proyecto]
  
  def fetch
    proyectos=(Proyecto.where(:user_id=>@user_id)+Proyecto.includes(:permisos).where("permisos.user_id"=>@user_id)).uniq
    #p Proyecto.find(23).permisos.all
    respond_to do |format|
        format.html{ render json: proyectos}
    end
  end
  
  def update_proyecto
    respond_to do |format|
      if @proyecto.update(proyecto_params)
        proyectos=(Proyecto.where(:user_id=>@user_id)+Proyecto.includes(:permisos).where("permisos.user_id"=>@user_id)).uniq
        #response={msge:{type: 'success', msg:"Proyecto actualizado satisfactoriamente"},proyectos:proyectos}
        format.html { render :json => proyectos, meta: {msge:{type: 'success', msg:"Proyecto actualizado satisfactoriamente"}}}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end

  def create
    @proyecto = Proyecto.new(proyecto_params)
    @proyecto.user_id=@user_id
    respond_to do |format|
      if @proyecto.save
        #response={msge:{type: 'success', msg:"Proyecto creado satisfactoriamente"},proyecto:@proyecto}
        format.html { render :json => @proyecto, meta: {msge:{type: 'success', msg:"Proyecto creado satisfactoriamente"}}}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def delete
    respond_to do |format|
      if @proyecto.destroy
        proyectos=Proyecto.where(:user_id=>@user_id)
        #response={msge:{type: 'success', msg:"Proyecto eliminado satisfactoriamente"},proyectos:proyectos}
        format.html { render :json => proyectos, meta: {msge:{type: 'success', msg:"Proyecto eliminado satisfactoriamente"}}}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end

  def set_access_control_headers 
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Max-Age'] = '6000'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with'
  end

  private
      def current_user
        return @current_user if defined?(@current_user)
      end
      
      def check_owner
        if @proyecto.user_id!=params[:user_id]
          #@proyecto.user_id
          p params[:user_id]
          response={msge:{type: 'warning', msg:"¡Estos no son sus proyectos!"}}
          respond_to do |format|
            format.html{ render json: response }
          end
        end
      end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_proyecto
      @proyecto = Proyecto.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def proyecto_params
      params.require(:proyecto).permit(:id,:nombre,:descripcion,:user_id)
    end
end
