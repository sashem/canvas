#encoding: utf-8
class CanvasController < ApplicationController
  before_action :set_canva, only: [:create,:delete, :update_canva, :fetch_canva, :save, :add_item, :remove_item]
  before_filter :check_session
  before_action :check_owner, only: [:delete]
  before_action :check_can_edit, only: [:update_canva, :save, :add_item, :remove_item,:create]
  before_action :check_can_view, only: [:fetch_canva]
  
  #def canvas
  #  render file: "public/canvas/index"
  #end
  
  def fetch
    canvas=Canva.where(:proyecto_id=>params["proyecto_id"])
    respond_to do |format|
        format.html{ render json: canvas, each_serializer: CanvaexpressSerializer}
    end
  end
  def fetch_canva
    respond_to do |format|
        format.html{ render json: @canva}
    end
  end
  
  def save
    tipos=["propuestas","recursos","actividades","canales","relaciones","segmentos","socios","costos","ingresos"]
    tipos.each do |item|
      prop_ids=[]
      itemsids=@canva.send(item).pluck(:id);
      if (itemsids!=[] and canva_params[item+"_attributes"])
          itemsids=itemsids.to_a
          canva_params[item+"_attributes"].each do |subitem|
              prop_ids.push(subitem[:id])
          end
      end
      todelete=itemsids-prop_ids
      todelete.each do |id|
        @canva.send(item).delete(id)
      end
    end
    
    respond_to do |format|
      if @canva.update(canva_params)
        response={msge:{type: 'success', msg:"Canvas guardado satisfactoriamente"}}
        format.html { render json: response}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end
  
  def update_canva
    respond_to do |format|
      if @canva.update(canva_params)
        canvas=Canva.where(:proyecto_id=>@canva.proyecto_id)
        response={msge:{type: 'success', msg:"Canvas actualizado satisfactoriamente"},canvas:canvas}
        format.html { render json: response}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end

  def create
    respond_to do |format|
      if @canva.save
        response={msge:{type: 'success', msg:"Canvas creado satisfactoriamente"},canva:@canva}
        format.html { render json: response}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end

  def delete
    respond_to do |format|
      if @canva.destroy
        canvas=Canva.where(:proyecto_id=>@proyecto_id)
        response={msge:{type: 'success', msg:"Proyecto eliminado satisfactoriamente"},canvas:canvas}
        format.html { render json: response}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end

  def add_item
    respond_to do |format|
      if @canva.update(canva_params) and @canva.proyecto.touch(:updated_at)
        format.html { render json: @canva}
      end
    end
  end
  
  def remove_item 
    seccion=params[:seccion].gsub("_attributes","")
    respond_to do |format|
      if params[:id_a_borrar]==-1
        if @canva.send(seccion).last.delete and @canva.proyecto.touch(:updated_at)
          format.html { render json: @canva}
        end
      end
      if params[:id_a_borrar]!=-1 and @canva.send(seccion).delete(params[:id_a_borrar]) and @canva.proyecto.touch(:updated_at)
        format.html { render json: @canva}
      end
    end
  end
  
  def set_access_control_headers 
      headers['Access-Control-Allow-Origin'] = ['localhost','http://calm-meadow-8426.herokuapp.com/','www.cec.uchile.cl/~sharfagar/canvasHelper']
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Max-Age'] = '6000'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with'
  end

  private
    def current_user
      return @current_user if defined?(@current_user)
    end
    def check_owner
      ## is owner
        if @canva.proyecto.user_id!=params[:user_id]
          response={msge:{type: 'warning', msg:"¡Estos no son sus canvas!"}}
          respond_to do |format|
            format.html{ render json: response }
          end
        end
    end
    def check_can_edit
      if (!@canva.proyecto.permisos.where("user_id = ? AND valor <=1",params[:user_id]).exists? and @canva.proyecto.user_id!=params[:user_id])
        response={msge:{type: 'warning', msg:"Usted no tiene derecho a editar este proyecto"}}
          respond_to do |format|
            format.html{ render json: response }
          end
      end
    end
    def check_can_view
      if (!@canva.proyecto.permisos.where("user_id = ? AND valor <=2",params[:user_id]).exists? and @canva.proyecto.user_id!=params[:user_id])
        response={msge:{type: 'warning', msg:"Usted no tiene derecho a ver este proyecto"}}
          respond_to do |format|
            format.html{ render json: response }
          end
      end
    end
    
  
    # Use callbacks to share common setup or constraints between actions.
    def set_canva
      if params[:id]
        @canva = Canva.find(params[:id])
        @proyecto_id=@canva.proyecto_id
      end
      if !params[:id]
        @canva = Canva.new(canva_params)
        @canva.proyecto_id=params[:proyecto_id]
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def canva_params
      params.require(:canva).permit(:id,:nombre,:descripcion,:proyecto_id,
        propuestas_attributes:[:id, :abreviacion, :descripcion, :color],
        recursos_attributes:[:id, :abreviacion, :descripcion, :color],
        actividades_attributes:[:id, :abreviacion, :descripcion, :color],
        clientes_attributes:[:id, :abreviacion, :descripcion, :color],
        segmentos_attributes:[:id, :abreviacion, :descripcion, :color],
        canales_attributes:[:id, :abreviacion, :descripcion, :color],
        relaciones_attributes:[:id, :abreviacion, :descripcion, :color],
        costos_attributes:[:id, :abreviacion, :descripcion, :color],
        socios_attributes:[:id, :abreviacion, :descripcion, :color],
        ingresos_attributes:[:id, :abreviacion, :descripcion, :color])
    end
    def mensaje_params
      params.require(:canva).permit(:id,mensajes_attributes:[:id,:contenido]);
    end
end
