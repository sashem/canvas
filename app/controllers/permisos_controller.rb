class PermisosController < ApplicationController
  before_filter :check_session
  before_action :set_permiso, only:[:delete,:edit]
  before_filter :check_permission
  def fetch
    permisos=Proyecto.find(params[:proyecto_id]).permisos
    respond_to do |format|
        format.html{ render json: permisos}
    end
  end
  
  def create
    if(check_permiso)
      permiso=Permiso.create(permiso_params)
      if permiso.save()
        respond_to do |format|
          format.html{ render json: permiso.proyecto.permisos }
        end
      end
    end
  end
  
  def edit
    if @permiso.update(permiso_params)
      respond_to do |format|
        format.html{ render json: @permiso.proyecto.permisos }
      end
    end
  end
  def delete
    permisos=Permiso.find(permiso_params[:id]).proyecto.permisos
    if Permiso.delete(permiso_params[:id])
      #response={msge:{type: 'warning', msg:"Su mensaje ha sido enviado"},msjes:mensajes}
      respond_to do |format|
        format.html{ render json: permisos }
      end
    end
  end
  private
  def check_permission
    proyecto=Proyecto.find(permiso_params[:proyecto_id])
    if(!proyecto.permisos.where(:user_id=>params[:user_id],:valor=>1).exists? and proyecto.user_id!=params[:user_id])
      response={msge:{type: 'warning', msg:"Usted no tiene derecho a editar estos permisos"}}
      respond_to do |format|
        format.html{ render json: response }
      end
    end
  end
  
  def set_permiso
    @permiso=Permiso.find(permiso_params[:id])
  end
  def check_permiso
    if(Permiso.where(:user_id=>permiso_params[:user_id],:proyecto_id=>permiso_params[:proyecto_id]).exists?)
      return false
    end
    return true
  end
  def permiso_params
      params.require(:permiso).permit(:id,:user_id,:proyecto_id, :valor)
  end

end