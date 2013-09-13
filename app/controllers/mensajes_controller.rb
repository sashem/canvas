class MensajesController < ApplicationController
  before_action :set_canvas
  before_filter :check_session # :check_permission
  
  def create
    mensaje=Mensaje.create(mensaje_params)
    mensaje.user_id=params[:my_user_id__]
    if mensaje.save()
      response={msge:{type: 'warning', msg:"¡Estos no son sus canvas!"},msjes:Mensaje.canva.mensajes}
      respond_to do |format|
        format.html{ render json: response }
      end
    end
  end
  
  private
  def check_permission
      
  end
  
  def mensaje_params
      params.require(:mensajes).permit(:id,:contenido,:canva_id)
  end

end