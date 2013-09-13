class MensajesController < ApplicationController
  before_filter :check_session # :check_permission
  
  def create
    mensaje=Mensaje.create(mensaje_params)
    mensaje.user_id=params[:my_user_id__]
    if mensaje.save()
      response={msge:{type: 'warning', msg:"Su mensaje ha sido enviado"},msjes:mensaje.canva.mensajes}
      respond_to do |format|
        format.html{ render json: response }
      end
    end
  end
  
  private
  
  def mensaje_params
      params.require(:mensaje).permit(:id,:contenido,:canva_id)
  end

end