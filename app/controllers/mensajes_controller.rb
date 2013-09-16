class MensajesController < ApplicationController
  before_filter :check_session
  before_filter :check_permission, only:[:delete]
  #before_action :set_mensaje
  def create
    mensaje=Mensaje.create(mensaje_params)
    mensaje.user_id=params[:user_id]
    if (!params[:user_id])
      response={msge:{type: 'warning', msg:"Debe ser un usuario registrado para enviar mensajes"},msjes:mensaje.canva.mensajes}
      respond_to do |format|
        format.html{ render json: response }
      end
    end
    if mensaje.save()
      respond_to do |format|
        format.html{ render json: mensaje.canva.mensajes }
      end
    end
  end
  def delete
    mensajes=Mensaje.find(mensaje_params[:id]).canva.mensajes
    if Mensaje.delete(mensaje_params[:id])
      #response={msge:{type: 'warning', msg:"Su mensaje ha sido enviado"},msjes:mensajes}
      respond_to do |format|
        format.html{ render json: mensajes }
      end
    end
  end
  private
  def check_permission
    mensaje=Mensaje.find(mensaje_params[:id])
      if (!mensaje.canva.proyecto.permisos.where(:user_id=>params[:user_id],:valor=>1).exists? and mensaje.canva.proyecto.user_id!=params[:user_id])
        response={msge:{type: 'warning', msg:"Usted no tiene derecho a editar este canvas"}}
          respond_to do |format|
            format.html{ render json: response }
          end
      end
    end
  
  
  def mensaje_params
      params.require(:mensaje).permit(:id,:contenido,:canva_id)
  end

end